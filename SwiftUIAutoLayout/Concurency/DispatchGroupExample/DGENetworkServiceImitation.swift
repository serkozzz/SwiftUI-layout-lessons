//
//  ColorsServiceImitation.swift
//  Sandbox4
//
//  Created by Sergey Kozlov on 23.10.2026.
//

import SwiftUI

final class RequestResults: @unchecked Sendable {
    var res1 = 0
    var res2 = 0
    var firstError: Error?
}


extension DispatchGroupExample {
    class NetworkServiceImitation {
        func getAllInfo(complete: @escaping (Result<Int, Error>) -> Void) {
            let group =  DispatchGroup()
            group.enter()
            let reqResults = RequestResults()
            emulateRequest() { result in
                DispatchQueue.main.async {
                    defer { group.leave() }
                    switch result {
                    case .success(let res):
                        reqResults.res1 = res
                    case .failure(let error):
                        if reqResults.firstError == nil { reqResults.firstError = error }
                    }
                }
            }
            
            group.enter()
            
            emulateRequest() { result in
                DispatchQueue.main.async {
                    defer { group.leave() }
                    switch result {
                    case .success(let res):
                        reqResults.res2 = res
                    case .failure(let error):
                        if reqResults.firstError == nil { reqResults.firstError = error }
                    }
                }
            }
            
            group.notify(queue: .main) {
                let result = reqResults.res1 + reqResults.res2
                if let firstError = reqResults.firstError {
                    complete(.failure(firstError))
                }
                else {
                    complete(.success(result))
                }
            }
            
        }
        
        func emulateRequest(complete: @escaping (Result<Int, Error>) -> Void) {
            
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: TimeInterval(1))
                let res = 3
                complete(.success(res))
            }
        }
    }
}
