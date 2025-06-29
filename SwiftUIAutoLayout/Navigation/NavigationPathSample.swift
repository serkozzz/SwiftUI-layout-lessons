//
//  NavigationPath.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 28.06.2025.
//

import SwiftUI


struct NavigationPathSample: View {
    @State var path =  NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button {
                    path.append(123)
                } label: {
                     Text("open details")
                }
 
            }
            .navigationTitle("Root")
            .navigationDestination(for: Int.self) { number in
                DetailView(path: $path, number: number)
            }
        }
    }
}



private struct DetailView: View {
    
    @Binding var path: NavigationPath
    var number: Int
    
    var body: some View {
        VStack {
            Text("Details View: \(number)")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.removeLast()
                } label: {
                    Text("Close")
                }
            }
        }
        .background(.yellow)
    }
}

#Preview {
    NavigationPathSample()
}
