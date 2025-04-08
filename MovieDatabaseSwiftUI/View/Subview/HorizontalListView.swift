//
//  HorizontalListView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 17/03/25.
//

import SwiftUI
import Kingfisher

struct HorizontalListView: View {
    let header: String
    @Binding var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .font(.customFont(style: .bold, size: 28))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
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
                                .overlay {
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: .clear, location: 0.7),
                                            Gradient.Stop(color: .black.opacity(0.6), location: 1)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                }
                                .overlay(alignment: .bottom) {
                                    VStack {
                                        Spacer()
                                        Text(movie.title)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 4)
                                            .padding(.bottom, 8)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .frame(width: 120, height: 180)
                                
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(height: 250)
    }
}

#Preview {
    HorizontalListView(header: Constants.nowPlayingString, movies: .constant(Movie.mockMovies))
}
