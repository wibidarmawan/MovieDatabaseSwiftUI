//
//  ErrorHandler.swift
//  BaseProjectSwiftUI
//
//  Created by Wibi Darmawan on 13/03/25.
//

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
    case customError(String)
}

class ErrorHandler {
    static func handle(error: Error) {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .badRequest:
                showAlert("Bad Request")
            case .unauthorized:
                showAlert("Unauthorized")
            case .forbidden:
                showAlert("Forbidden")
            case .notFound:
                showAlert("Request not found")
            case .serverError:
                showAlert("Server Error")
            case .unknown:
                showAlert("An unkown error occured")
            case .customError(let msg):
                showAlert("Error: \(msg)")
            }
        }
    }
    
    private static func showAlert(_ message: String) {
        // create a alert
        print(message)
    }
}
