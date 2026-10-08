//
//  ServerAPI.swift
//  PicturesViewerFromBook
//
//  Created by Sergey Kozlov on 22.09.2026.
//

import SwiftUI

@MainActor
class ServerAPI {
    static let endpoint = "https://picsum.photos/v2/list"
    
    func getImage(_ url: String) async throws -> UIImage {
        let data = try await sendGETRequest(url)
        guard let image = UIImage(data: data) else {
            throw ServerAPIError.invalidBodyData
        }
        return image
    }
    
    func getJSON<T: Decodable>(_ urlStr: String) async throws -> T {
        let data = try await sendGETRequest(urlStr)
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        }
        catch {
            throw ServerAPIError.invalidBodyData
        }
    }
    
    
    private func sendGETRequest(_ urlStr: String) async throws -> Data {
        guard let url = URL(string: urlStr) else {
            throw ServerAPIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse else {
                throw ServerAPIError.unknown
            }
            guard (200..<300).contains(response.statusCode) else {
                throw ServerAPIError(
                    statusCode: response.statusCode)
            }
            return data
        }
        catch is CancellationError {
            throw ServerAPIError.cancellation
        } catch let error as URLError where error.code == .cancelled {
            throw ServerAPIError.cancellation
        }
        catch let error as ServerAPIError {
            throw error
        }
        catch  {
            throw ServerAPIError.unknown
        }
    }
}

