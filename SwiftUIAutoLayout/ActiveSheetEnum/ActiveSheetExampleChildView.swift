
//
//  ActiveSheetExampleChildView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 19.04.2026.
//


import SwiftUI

struct ActiveSheetExampleChildView: View {
    var onFinished: (String) -> Void
    @State private var userText: String = ""
    
    init(onFinished: @escaping (String) -> Void ) {
        self.onFinished = onFinished
        
    }
    var body: some View {
        VStack {
            TextField("input the text", text: $userText)
            Button("finish") {
                self.onFinished(userText)
            }
        }
   
    }
    
}
