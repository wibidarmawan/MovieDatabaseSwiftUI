//
//  HomeViewModel.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 20/03/25.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var nowPlayingMovies: MovieListModel = MovieListModel()
    @Published var topRated: MovieListModel = MovieListModel()
    @Published var upcoming: MovieListModel = MovieListModel()
    @Published var popular: MovieListModel = MovieListModel()
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    func getMovieList(_ listType: MovieList, defaultParam: DefaultParam = DefaultParam()) {
        isLoading = true
        Task {
            do {
                let movies: MovieListModel = try await ServiceLayer.request(router: .getMovieList(listType, defaultParam: defaultParam))
                updateMovies(listType, with: movies)
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    private func updateMovies(_ listType: MovieList, with movies: MovieListModel) {
        switch listType {
        case .nowPlaying:
            nowPlayingMovies = movies
        case .topRated:
            topRated = movies
        case .upcoming:
            upcoming = movies
        case .popular:
            popular = movies
        }
    }
    
}
