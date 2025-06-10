//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI


struct Variable: View {
    @State var items = Array(0...10)
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button() {
                    items.append(11)
                } label: { Image(systemName: "plus") }
                    .padding()
                    .border(.black)
                    .padding()
            }
            Spacer()
            let visibleItems = items.filter { $0 > 5 }
            HStack() {
                ForEach(visibleItems, id: \.self) { item in
                    Text(String(item))
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                }
            }
            Spacer()

        }
    }
    
    
    private func createString() -> String {
        print("Hello world")
        return "Hello world"
    }
}

#Preview {
    Variable()
}
