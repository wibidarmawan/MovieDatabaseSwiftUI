//
//  DecoderService.swift
//  BaseProjectSwiftUI
//
//  Created by Wibi Darmawan on 13/03/25.
//

import Foundation

class JSONDecoderService {
    static func decode<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let decoderObject = try decoder.decode(T.self, from: data)
        return decoderObject
    }
}
