//
//  ServerAPI.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//

import SwiftUI
import Combine

extension PhotoViewerDispatchQuieue {
    class ServerAPI {
        static let endpoint = "https://showroom.calico.blackmana.com/api/1.2/fabrics/colors"
        
        func sendImageRequest(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void ){
            
            sendGETRequest(urlString: urlString) { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(.failure(ServerAPIError.invalidBodyData))
                        return
                    }
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
        
        
        func sendJSONRequest<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void ) {
            sendGETRequest(urlString: urlString) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(ServerAPIError.invalidBodyData))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        func sendGETRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(.failure(ServerAPIError.invalidURL))
                return
            }
            let urlRequest = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let urlError = error as? URLError {
                    completion(.failure(ServerAPIError(urlError: urlError)))
                    return
                }
                if error != nil {
                    completion(.failure(ServerAPIError.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(ServerAPIError.internetError))
                    return
                }
                guard (200...300).contains(httpResponse.statusCode) else {
                    completion(.failure(ServerAPIError(httpResponseCode: httpResponse.statusCode)))
                    return
                }
                guard let data = data else {
                    completion(.failure(ServerAPIError.invalidBodyData))
                    return
                }
                completion(.success(data))
            }.resume()
        }
    }
}
