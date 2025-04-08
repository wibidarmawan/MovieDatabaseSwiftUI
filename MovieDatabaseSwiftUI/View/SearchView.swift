import SwiftUI
import Kingfisher

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    if viewModel.searchResults.results.isEmpty && !viewModel.isLoading {
                        Section {
                            if searchText.isEmpty {
                                Text("Search for movies")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .listRowBackground(Color.clear)
                                    .padding()
                            } else {
                                Text("No results found")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .listRowBackground(Color.clear)
                                    .padding()
                            }
                        }
                    } else {
                        Section {
                            ForEach(viewModel.searchResults.results, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    MovieSearchRow(movie: movie)
                                        .padding(.vertical, 8)
                                        .onAppear {
                                            viewModel.loadMoreIfNeeded(movie: movie)
                                        }
                                }
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                            }
                            
                            // Loading indicator at the bottom
                            if viewModel.isLoadingMore {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .padding()
                                    Spacer()
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Search Movies")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for movies")
                .onSubmit(of: .search) {
                    if !searchText.isEmpty {
                        viewModel.searchMovies(query: searchText)
                    }
                }
                .submitLabel(.search)
                .overlay(
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.black.opacity(0.1))
                        }
                    }
                )
                
                // Pagination info view
                if !viewModel.searchResults.results.isEmpty && viewModel.hasMorePages {
                    Text("Page \(viewModel.currentPage) of \(viewModel.searchResults.totalPages)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.8))
                                .shadow(radius: 2)
                        )
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

// Simplified MovieSearchRow
struct MovieSearchRow: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            // Movie poster with fallback
            KFImage.url(URL(string: movie.posterUrl))
                .resizable()
                .placeholder {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "film")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        )
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 120)
                .cornerRadius(8)
            
            // Movie info
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let releaseDate = movie.releaseDate,
                   !releaseDate.isEmpty {
                    Text(releaseDate.formattedDate())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.footnote)
                    Text(String(format: "%.1f", movie.voteAverage ?? 0))
                        .font(.footnote)
                }
                
                if let overview = movie.overview {
                    Text(overview)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
} 
