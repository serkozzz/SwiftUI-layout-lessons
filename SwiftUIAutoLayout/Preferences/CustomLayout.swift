//
//  CustomLayout.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 14.06.2025.
//

import SwiftUI


struct CollectSizePreference: PreferenceKey {
    static let defaultValue: [Int: CGSize] = [:]
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct CollectSize: ViewModifier {
    var index: Int
    func body(content: Content) -> some View {
        content.background {
            GeometryReader { proxy in
                Color.clear.preference(key: CollectSizePreference.self, value: [self.index : proxy.size])
            }
        }
    }
}



struct CustomLayout: View {
    let colors: [(Color, CGFloat)] = [(.red, 50), (.green, 30), (.blue, 75)]
    @State var horizontal: Bool = true
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.default) {
                    self.horizontal.toggle()
                }
            }) { Text("Toggle axis") }
            Stack(elements: colors, axis: horizontal ? .horizontal : .vertical) { item in
                Rectangle()
                    .fill(item.0)
                    .frame(width: item.1, height: item.1)
            }
            .border(Color.black)
        }
    }
}

struct Stack<Element, Content: View>: View {
    
    var elements: [Element]
    var spacing: CGFloat = 8
    var axis: Axis = .horizontal
    var alignment: Alignment = .topLeading
    var content: (Element) -> Content
    
    @State private var offsets: [CGPoint] = []
   
    var body: some View {
        ZStack(alignment: alignment) {
            ForEach(elements.indices) { idx in
                self.content(self.elements[idx])
                    .modifier(CollectSize(index: idx))
                    .alignmentGuide(self.alignment.horizontal, computeValue: {
                        self.axis == .horizontal
                        ? -self.offset(at: idx).x
                        : $0[self.alignment.horizontal]
                    })
                    .alignmentGuide(self.alignment.vertical, computeValue: {
                        self.axis == .vertical
                        ? -self.offset(at: idx).y
                        : $0[self.alignment.vertical]
                    })
            }
        }
        .onPreferenceChange(CollectSizePreference.self) { sizes in
            Task { @MainActor in
                self.computeOffsets(sizes: sizes)
            }
        }
    }


    
    private func computeOffsets(sizes: [Int: CGSize]) {
        guard !sizes.isEmpty else { return }
        var offsets: [CGPoint] = [.zero]
        for idx in 0..<self.elements.count {
            guard let size = sizes[idx] else { fatalError() }
            var newPoint = offsets.last!
            newPoint.x += size.width + self.spacing
            newPoint.y += size.height + self.spacing
            offsets.append(newPoint)
        }
        self.offsets = offsets
    }

    //метод нужен только потому что в первом layout pass массив offsets ещё не заполнен
    //и мы возвращаем .zero
    nonisolated private func offset(at index: Int) -> CGPoint {
        guard index < _offsets.wrappedValue.endIndex else { return .zero }
        return _offsets.wrappedValue[index]
    }
}


#Preview {
    CustomLayout()
}
