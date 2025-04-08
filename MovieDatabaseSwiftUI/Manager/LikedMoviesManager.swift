import Foundation

@MainActor
class LikedMoviesManager: ObservableObject {
    @Published private(set) var likedMovies: [Int: MovieDetailModel] = [:]
    private let userDefaults = UserDefaults.standard
    private let likedMoviesKey = "LikedMoviesData"
    
    static let shared = LikedMoviesManager()
    
    private init() {
        // Load liked movies from UserDefaults
        if let savedData = userDefaults.data(forKey: likedMoviesKey),
           let decodedMovies = try? JSONDecoder().decode([Int: MovieDetailModel].self, from: savedData) {
            likedMovies = decodedMovies
        }
    }
    
    func toggleLike(for movie: MovieDetailModel) {
        if likedMovies[movie.id] != nil {
            likedMovies.removeValue(forKey: movie.id)
        } else {
            likedMovies[movie.id] = movie
        }
        // Save to UserDefaults
        saveToUserDefaults()
    }
    
    func isLiked(_ movieId: Int) -> Bool {
        likedMovies[movieId] != nil
    }
    
    func getLikedMovie(_ movieId: Int) -> MovieDetailModel? {
        return likedMovies[movieId]
    }
    
    func getAllLikedMovies() -> [MovieDetailModel] {
        return Array(likedMovies.values)
    }
    
    private func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(likedMovies) {
            userDefaults.set(encodedData, forKey: likedMoviesKey)
        }
    }
} 