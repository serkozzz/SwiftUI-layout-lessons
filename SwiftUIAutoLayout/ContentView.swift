//
//  ContentView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HStack {
                
                Text("Hello, world!")
                
                VStack(alignment: .leading) {
                    Text("Hello, world!")
                    Text("Hello, asd asd world!")
                    NavigationLink(destination: DetailView()) {
                        Text("Перейти")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .background(.yellow)
                Text("Hello, world!")
            }
            .background(.blue)
        }
    }
}

private struct DetailView: View {
    var body: some View {
        Rectangle()
            .fill(.blue)
    }
}



#Preview {
    ContentView()
}
