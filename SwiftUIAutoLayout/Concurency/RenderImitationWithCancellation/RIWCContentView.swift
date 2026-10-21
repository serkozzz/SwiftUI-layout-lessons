//
//  sandbox3App.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 20.10.2026.
//

import SwiftUI

enum RenderImitationWithCancellation {
    struct ContentView: View {
        let renderEngine: RenderEngine
        @StateObject var renderManagerViewModel: RenderManagerViewModel
        
        init() {
            let renderEngine = RenderEngine()
            self.renderEngine = renderEngine
            self._renderManagerViewModel = StateObject(wrappedValue: RenderManagerViewModel(renderEngine: renderEngine))
        }
        var body: some View {
            
            RenderManagerView(viewModel: renderManagerViewModel)
            
        }
    }
}
