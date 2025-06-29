//
//  NavigationPath.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 28.06.2025.
//

import SwiftUI

enum Route: Hashable {
    case left(Int)
    case right(String)
}

struct TestStruct : Hashable {
    var a = 10
    var s = "String"
}

struct NavigationPathTree: View {
    @State var path =  NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                
                Button {
                    path.append(Route.left(99))
                } label: {
                    Text("open left details")
                }
                Button {
                    path.append(Route.right("right"))
                } label: {
                    Text("open right details")
                }
                
            }
            .navigationTitle("Root")
            .navigationDestination(for: Route.self) { route in
                switch(route) {
                case .left(let number):
                    LeftDetailView(path: $path, number: number)
                    
                case .right(let str):
                    RightDetailView(path: $path, str: str)

                }
            }
        }
    }
}


private struct LeftDetailView: View {
    
    @Binding var path: NavigationPath
    var number: Int
    
    var body: some View {
        VStack {
            Text("Left Details View: \(number)")
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
        .navigationDestination(for: Int.self) { number in
                //will never be called because path.append is in the other tree brach
                Text("never be callded")
            }
            
        .background(.yellow)
    }
}

private struct RightDetailView: View {
    
    @Binding var path: NavigationPath
    var str: String
    
    var body: some View {
        VStack {
            Text("Right Details View: \(str)")
            Button {
                path.append(123)
            } label: {
                Text("appempt to open destination from left branch")
            }
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
    NavigationPathTree()
}
