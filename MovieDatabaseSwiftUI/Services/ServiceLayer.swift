//
//  ServiceLayer.swift
//  BaseProjectSwiftUI
//
//  Created by Wibi Darmawan on 13/03/25.
//

class ServiceLayer {
    static func request<T: Codable>(router: Router) async throws -> T {
        let request = try AppNetworking.buildRequest(from: router)
        let data = try await NetworkManager.requestData(for: request)
        let responseObject: T = try JSONDecoderService.decode(data: data)
        return responseObject
    }
}
