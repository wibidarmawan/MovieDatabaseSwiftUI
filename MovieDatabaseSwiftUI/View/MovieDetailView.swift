//
//  MovieDetailView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 17/03/25.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    
    let movieId: Int
    @StateObject var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    @ObservedObject var likedManager = LikedMoviesManager.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Backdrop image with like button overlay
                ZStack(alignment: .topTrailing) {
                    ZoomableImageView(
                        imageURL: viewModel.movieDetail.backdropPathUrl,
                        title: viewModel.movieDetail.title,
                        showExpandIcon: false
                    )
                    .frame(minHeight: 200)
                    
                    AnimatedHeartButton(
                        isLiked: likedManager.isLiked(movieId)
                    ) {
                        likedManager.toggleLike(for: viewModel.movieDetail)
                    }
                    .padding(16)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    // Title and Poster Section
                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: 16) {
                            // Poster with zoom functionality
                            ZoomableImageView(
                                imageURL: viewModel.movieDetail.posterUrl,
                                title: viewModel.movieDetail.title,
                                placeholder: AnyView(
                                    Rectangle()
                                        .foregroundColor(.gray.opacity(0.2))
                                        .overlay(
                                            Image(systemName: "film")
                                                .font(.largeTitle)
                                                .foregroundColor(.gray)
                                        )
                                ),
                                cornerRadius: 8,
                                frameSize: CGSize(width: 120, height: 200)
                            )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.movieDetail.title)
                                    .titleFont()
                                    .accessibilityLabel("Movie title: \(viewModel.movieDetail.title)")
                                
                                if let releaseDate = viewModel.movieDetail.releaseDate {
                                    Text("Release Date: \(releaseDate.isEmpty ? "-" : releaseDate.formattedDate())")
                                        .captionFont()
                                        .foregroundColor(.gray)
                                }
                                
                                // Genres Grid
                                GridFlowLayout(spacing: 8) {
                                    ForEach(viewModel.movieDetail.genres, id: \.id) { genre in
                                        Text(genre.name)
                                            .font(.customFont(style: .regular, size: 10))
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.gray.opacity(0.2))
                                            )
                                    }
                                }
                                .padding(.top, 4)
                                
                                HStack(alignment: .center) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .accessibilityLabel("Rating")
                                    Text(String(format: "%.1f", viewModel.movieDetail.voteAverage))
                                        .font(.customFont(style: .medium, size: 14))
                                }
                                .padding(.top, 4)
                                
                                Spacer()
                            }
                        }
                        
                        // Overview
                        if let overview = viewModel.movieDetail.overview,
                           !overview.isEmpty{
                            Text("Overview")
                                .subtitleFont()
                                .padding(.top, 8)
                            
                            Text(overview)
                                .bodyFont()
                                .lineSpacing(4)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    if ($viewModel.credits.cast.count != 0) {
                        CastListView(header: "Casts", casts: $viewModel.credits.cast)
                    }
                    
                    if ($viewModel.recommendations.results.count != 0) {
                        HorizontalListView(header: Constants.recommendationsString, movies: $viewModel.recommendations.results)
                    }
                }
            }
        }
        .navigationTitle(viewModel.movieDetail.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .task {
            viewModel.getMovieDetail(movieId)
            viewModel.getMovieCredits(movieId)
            viewModel.getMovieRecommendations(movieId)
        }
    }
}
