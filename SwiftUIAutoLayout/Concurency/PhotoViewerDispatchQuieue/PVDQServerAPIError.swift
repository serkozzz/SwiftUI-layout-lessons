//
//  ServerAPIError.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//

import SwiftUI

extension PhotoViewerDispatchQuieue {
    enum ServerAPIError: Error {
        case invalidURL
        case internetError
        case invalidBodyData
        case unknown
        
        init(urlError: URLError) {
            switch urlError.code {
            case .notConnectedToInternet:
                self = .internetError
            default:
                self = .unknown
            }
        }
        
        init(httpResponseCode: Int) {
            switch httpResponseCode {
            case (400...500):
                self = .unknown
            default:
                self = .unknown
            }
        }
    }
}
