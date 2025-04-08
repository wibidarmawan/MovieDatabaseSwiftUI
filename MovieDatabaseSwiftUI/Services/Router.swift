//
//  Router.swift
//  BaseProjectSwiftUI
//
//  Created by Wibi Darmawan on 13/03/25.
//

import Foundation

enum MovieList: String {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    case popular = "popular"
}

enum Router {
    
    case getMovieList(_ movieList: MovieList, defaultParam: DefaultParam)
    case getMovieDetail(_ movieId: Int)
    case getMovieRecommendations(_ movieId: Int)
    case getMovieCredits(_ movieId: Int)
    case searchMovie(query: String, page: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
            return ApiConfig.shared.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getMovieList(let movieList, _):
            return "/3/movie/\(movieList.rawValue)"
        case .getMovieDetail(let movieId):
            return "/3/movie/\(movieId)"
        case .getMovieRecommendations(let movieId):
            return "/3/movie/\(movieId)/recommendations"
        case .getMovieCredits(let movieId):
            return "/3/movie/\(movieId)/credits"
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        default:
            return [:]
        }
      }
    
    var query: [URLQueryItem] {
        switch self {
        case .searchMovie(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: String(page))
            ]
        default:
            return []
        }
    }
}
