//
//  RenderEngine.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 22.10.2026.
//


import SwiftUI


extension RenderImitationGCD {
    class RenderEngine {
        
        let queue = DispatchQueue(label: "rendersQueue", attributes: .concurrent)
        
        private func render() {
            Thread.sleep(forTimeInterval: 0.1)
        }
        
        func startRender(onProgress: @escaping (Double) -> Void, completion: @escaping (Result<UIImage, Error>) -> Void ) {
            
            //можно вместо queue и DispatchQueue.global(), будет одно и то же. В обоих случаях каждый рендер будет на отдельном потоке
            queue.async { [weak self] in
                
                guard let self else { return }
                for i in 0...100 {
                    render()
                    onProgress(Double(i) / 100.0)
                }
                completion(.success(UIImage(systemName: "arrow.up")!))
                
            }
        }
    }
}
