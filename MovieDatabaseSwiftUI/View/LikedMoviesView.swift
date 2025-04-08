import SwiftUI
import Kingfisher

struct LikedMoviesView: View {
    @ObservedObject var likedManager = LikedMoviesManager.shared
    
    var body: some View {
        NavigationView {
            if likedManager.getAllLikedMovies().isEmpty {
                ContentUnavailableView(
                    "No Liked Movies",
                    systemImage: "heart",
                    description: Text("Movies you like will appear here")
                )
            } else {
                List {
                    ForEach(likedManager.getAllLikedMovies()) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            HStack(spacing: 12) {
                                KFImage.url(URL(string: movie.posterUrl))
                                    .resizable()
                                    .placeholder {
                                        Rectangle()
                                            .foregroundColor(.gray.opacity(0.2))
                                    }
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 90)
                                    .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(movie.title)
                                        .font(.headline)
                                    
                                    if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
                                        Text(releaseDate.formattedDate())
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                        Text(String(format: "%.1f", movie.voteAverage))
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let moviesToDelete = indexSet.map { likedManager.getAllLikedMovies()[$0] }
                        for movie in moviesToDelete {
                            likedManager.toggleLike(for: movie)
                        }
                    }
                }
                .navigationTitle("Liked Movies")
                .toolbar {
                    EditButton()
                }
            }
        }
    }
} 
