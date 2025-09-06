//
//  KeyFrameAnimSample.swift
//  sandbox
//
//  Created by Sergey Kozlov on 05.09.2025.
//

import SwiftUI

struct KeyFrameAnimSample: View {
    var totalDuration = 2.0
    
    
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(.orange)
            .frame(width: 100, height: 100)
            .keyframeAnimator(initialValue: AnimaptionProperties(), repeating: true) { content, value in
                content
                    .scaleEffect(value.vStretch, anchor: .bottom)
                    .offset( y: value.yTranslation)
                
            } keyframes:  { _ in
                KeyframeTrack(\.vStretch) {
                    SpringKeyframe(0.6, duration: totalDuration * 0.15)
                    CubicKeyframe(1, duration: totalDuration * 0.15)
                    CubicKeyframe(1.2, duration: totalDuration * 0.4)
                    CubicKeyframe(1.1, duration: totalDuration * 0.15)
                    SpringKeyframe(1, duration: totalDuration * 0.15)
                }
                
                KeyframeTrack(\.yTranslation) {
                    CubicKeyframe(0, duration: totalDuration * 0.1)
                    CubicKeyframe(-100, duration: totalDuration * 0.3)
                    CubicKeyframe(-100, duration: totalDuration * 0.3)
                    CubicKeyframe(0, duration: totalDuration * 0.3)
                }
            }
        
    }
}

struct AnimaptionProperties {
    var yTranslation = 0.0
    var vStretch =  1.0
}

#Preview {
    KeyFrameAnimSample()
}


