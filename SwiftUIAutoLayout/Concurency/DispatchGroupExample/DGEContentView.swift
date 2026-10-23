//
//  ContentView.swift
//  Sandbox4
//
//  Created by Sergey Kozlov on 19.10.2026.
//

import SwiftUI

enum DispatchGroupExample {
    struct ContentView: View {
        
        @State var text: String = "init"
        var networkServiceImitation = NetworkServiceImitation()
        
        var body: some View {
            
            Text(text)
                .task {
                    networkServiceImitation.getAllInfo() { result in
                        switch result {
                        case .success(let res):
                            self.text = "result = \(res)"
                            print(text)
                        case .failure(let error):
                            self.text = "error: \(error)"
                            print(text)
                        }
                        
                    }
                }
        }
    }
    
}
