//
//  MovieDetailViewModel.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 23/03/25.
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetailModel = MovieDetailModel()
    @Published var recommendations: MovieListModel = MovieListModel()
    @Published var credits: CreditsModel = CreditsModel()
    
    func getMovieDetail(_ movieId: Int) {
        Task {
            do {
                movieDetail = try await ServiceLayer.request(router: .getMovieDetail(movieId))
            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
    
    func getMovieRecommendations(_ movieId: Int) {
        Task {
            do {
                recommendations = try await ServiceLayer.request(router: .getMovieRecommendations(movieId))
            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
    
    func getMovieCredits(_ movieId: Int) {
        Task {
            do {
                credits = try await ServiceLayer.request(router: .getMovieCredits(movieId))
            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
    
}
