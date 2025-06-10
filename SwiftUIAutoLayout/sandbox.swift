//
//  sandbox.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 10.06.2025.
//

import SwiftUI

struct sandbox: View {
    var body: some View {
        HStack {
            Cell()
            Cell()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct Cell: View {
    var body: some View {
        Rectangle()
            .frame(width: 50)
    }
}

#Preview {
    sandbox()
}
