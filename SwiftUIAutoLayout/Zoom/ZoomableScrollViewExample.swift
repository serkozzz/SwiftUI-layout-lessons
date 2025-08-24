//
//  ZoomableScrollViewExample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 19.08.2025.
//

import SwiftUI

struct ZoomableScrollViewExample: View {
    
    var body: some View {
        ZoomableScrollView(maxZoomScale: 3) {
            Image("beatImage").resizable().aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    ZoomableScrollViewExample()
}

