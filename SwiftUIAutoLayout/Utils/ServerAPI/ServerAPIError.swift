//
//  ServerAPIError.swift
//  PicturesViewerFromBook
//
//  Created by Sergey Kozlov on 23.09.2026.
//

import SwiftUI

enum ServerAPIError: Error {
    case invalidURL
    case invalidBodyData
    case noInternet
    case timeout
    case networkError
    case unknown
    case cancellation
}

extension ServerAPIError {
    init(_ urlError: URLError) {
        switch urlError.code {
        case .notConnectedToInternet,
             .networkConnectionLost,
             .cannotFindHost,
             .cannotConnectToHost:
            self = .noInternet
        case .timedOut:
            self = .timeout
        default:
            self = .unknown
        }
    }
}

extension ServerAPIError {
    init(statusCode: Int) {
        switch statusCode {
        case 401...404:
            self = .unknown
            
        case 500..<600:
            self = .unknown
            
        default:
            self = .unknown
        }
    }
}
