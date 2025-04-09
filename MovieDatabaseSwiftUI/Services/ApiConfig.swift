//
//  ApiConfig.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 19/03/25.
//

import Foundation

class ApiConfig {
    static let shared = ApiConfig()
    
    let baseUrl = "api.themoviedb.org"
    let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String else {
            fatalError("TMDB_API_KEY not found in Info.plist. Please ensure it's set in Config.xcconfig")
        }
        return apiKey
    }
}
