//
//  CreditsModel.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 24/03/25.
//

import Foundation

// MARK: - Credits Model
struct CreditsModel: Codable, Hashable {
    let id: Int
    var cast: [Cast]
    let crew: [Crew]
    
    init(
        id: Int = 0,
        cast: [Cast] = [],
        crew: [Crew] = []
    ) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}

// MARK: - Cast Model
struct Cast: Codable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String
    let creditID: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, character, order
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case creditID = "credit_id"
    }
    
    init(
        adult: Bool = false,
        gender: Int = 0,
        id: Int = 0,
        knownForDepartment: String = "",
        name: String = "",
        originalName: String = "",
        popularity: Double = 0.0,
        profilePath: String? = nil,
        castID: Int? = nil,
        character: String = "",
        creditID: String = "",
        order: Int = 0
    ) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.order = order
    }
    
    var profilePathUrl: String {
        return ApiConfig.shared.imageUrl + (profilePath ?? "")
    }
}

// MARK: - Crew Model
struct Crew: Codable, Hashable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditID: String
    let department: String
    let job: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, department, job
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case creditID = "credit_id"
    }
}
