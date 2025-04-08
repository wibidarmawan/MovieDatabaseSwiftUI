import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchResults: MovieListModel = MovieListModel()
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error: Error?
    @Published var currentPage = 1
    @Published var hasMorePages = true
    private var lastSearchQuery = ""
    
    func searchMovies(query: String, page: Int = 1) {
        guard !query.isEmpty else {
            searchResults = MovieListModel()
            currentPage = 1
            hasMorePages = false
            return
        }
        
        // Reset if this is a new search
        if query != lastSearchQuery || page == 1 {
            searchResults = MovieListModel()
            currentPage = 1
            hasMorePages = true
            isLoading = true
        } else {
            isLoadingMore = true
        }
        
        lastSearchQuery = query
        
        Task {
            do {
                let results: MovieListModel = try await ServiceLayer.request(router: .searchMovie(query: query, page: page))
                if page == 1 {
                    searchResults = results
                } else {
                    // Append new results to existing ones
                    var updatedResults = searchResults
                    updatedResults.results.append(contentsOf: results.results)
                    searchResults = updatedResults
                }
                
                // Check if we've reached the last page
                currentPage = page
                hasMorePages = results.page < results.totalPages
            } catch {
                self.error = error
            }
            
            isLoading = false
            isLoadingMore = false
        }
    }
    
    func loadMoreIfNeeded(movie: Movie) {
        guard !isLoading,
              !isLoadingMore,
              hasMorePages,
              let lastMovie = searchResults.results.last,
              lastMovie.id == movie.id,
              !lastSearchQuery.isEmpty else {
            return
        }
        
        searchMovies(query: lastSearchQuery, page: currentPage + 1)
    }
} 
