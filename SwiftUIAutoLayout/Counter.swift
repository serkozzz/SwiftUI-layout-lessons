//
//  Counter.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.06.2025.
//

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}


struct CounterView: View {
    @State var counter = 0
    var body: some View {
        VStack {
            Button(action: { self.counter += 1 }, label: {
                Text("Tap me!")
                    .padding()
                    .background(Color(.tertiarySystemFill))
                    .cornerRadius(5)
            })
            if counter > 0 {
                Text("You've tapped \(counter) times")
            } else {
                Text("You've not yet tapped")
            }
        }
        .debug()
    }
}

#Preview {
    CounterView()
}
