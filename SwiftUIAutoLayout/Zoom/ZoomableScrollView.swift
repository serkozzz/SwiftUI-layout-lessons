//
//  Zoomable.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 19.08.2025.
//

import SwiftUI

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    private var maxZoomScale: CGFloat
    private var minZoomScale: CGFloat
    
    init(maxZoomScale: CGFloat = 5, minZoomScale: CGFloat = 1, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.maxZoomScale = maxZoomScale
        self.minZoomScale = minZoomScale
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = self.maxZoomScale
        scrollView.minimumZoomScale = self.minZoomScale
        scrollView.bouncesZoom = true
        
        //hostedView is our swiftUI content placed inside UIScrollView
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}
