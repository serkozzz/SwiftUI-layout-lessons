//
//  ContentView.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 21.10.2026.
//

import SwiftUI


enum RenderImitationGCD {
    struct ContentView: View {
        let renderEngine: RenderEngine
        @StateObject var renderManagerVM: RenderManagerViewModel
        
        init() {
            let renderEngine = RenderEngine()
            self.renderEngine = renderEngine
            self._renderManagerVM = StateObject(wrappedValue: RenderManagerViewModel(renderEngine: renderEngine))
        }
        
        var body: some View {
            RenderManagerView(viewModel: renderManagerVM)
        }
    }
}
