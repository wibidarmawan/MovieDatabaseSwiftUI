//
//  MovieListModel.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 20/03/25.
//

import Foundation

// MARK: - MovieListModel Model
struct MovieListModel: Codable, Hashable {
    let page: Int
    var results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(
        page: Int = 0,
        results: [Movie] = [],
        totalPages: Int = 0,
        totalResults: Int = 0
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Movie Model
struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(
        adult: Bool = false,
        backdropPath: String? = nil,
        genreIds: [Int]? = [],
        id: Int = 0,
        originalLanguage: String = "",
        originalTitle: String = "",
        overview: String? = "",
        popularity: Double? = 0.0,
        posterPath: String? = nil,
        releaseDate: String? = "",
        title: String = "",
        video: Bool? = false,
        voteAverage: Double? = 0.0,
        voteCount: Int? = 0
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    var posterUrl: String {
        return ApiConfig.shared.imageUrl + (posterPath ?? "")
    }
}

extension Movie {
    static var mockMovies: [Movie] = [
        Movie(
            backdropPath: "/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg",
            id: 1,
            overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            posterPath: "/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg",
            releaseDate: "2010-07-16",
            title: "Inception",
            voteAverage: 8.8
        ),
        Movie(
            backdropPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            id: 2,
            overview: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
            posterPath: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            releaseDate: "2008-07-18",
            title: "The Dark Knight",
            voteAverage: 9.0
        ),
        Movie(
            backdropPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
            id: 3,
            overview: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
            posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
            releaseDate: "2014-11-07",
            title: "Interstellar",
            voteAverage: 8.6
        )
    ]
}

