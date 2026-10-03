//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 17.09.2026.
//

import SwiftUI
import Charts

enum AsyncStreamExample {
    struct ContentView: View {
        
        @StateObject var viewModel = ViewModel()
        var body: some View {
            VStack {
                List(viewModel.equations) {
                    Text($0.text())
                }
                HStack {
                    Button("TaskGroup") {
                        Task {
                            await viewModel.calculateAll(.groupTask)
                        }
                    }
                        .buttonStyle(.borderedProminent)
                    Spacer()
                    Button("Task") {
                        Task {
                            await viewModel.calculateAll(.unstructed)
                        }
                    }
                        .buttonStyle(.borderedProminent)
                    Toggle(isOn: $viewModel.emulateException) {
                        Text( "1st item exception")
                    }
                }
                Chart() {
                    
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

