//
//  SegmentedControlView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 28.01.2026.
//


import SwiftUI


struct SegmentedControlView: View {
    let titles: [String]
    @Binding var selectedIndex: Int
    
    var selectedColor: Color = .blue
    var backgroundColor: Color = Color(UIColor.systemBackground)
    var borderColor: Color = Color.blue.opacity(0.4)
    var dividerColor: Color = Color.blue.opacity(0.2)
    var textSelectedColor: Color = .white
    var textUnselectedColor: Color = .primary // по умолчанию системный цвет текста
    var cornerRadius: CGFloat = 8
    var verticalPadding: CGFloat = 8
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(titles.indices, id: \.self) { index in
                segment(title: titles[index], index: index)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .animation(.easeInOut(duration: 0.15), value: selectedIndex)
    }
    
    @ViewBuilder
    private func segment(title: String, index: Int) -> some View {
        let isSelected = selectedIndex == index
        Button {
            selectedIndex = index
        } label: {
            // Важно: растягиваем label на всю доступную ширину и задаём форму для хит-тестов
            Text(title)
                .font(.system(.subheadline, weight: .semibold))
                .foregroundColor(isSelected ? textSelectedColor : textUnselectedColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, verticalPadding)
                .background(
                    Group {
                        if isSelected {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(selectedColor)
                                .transition(.opacity.combined(with: .scale))
                        } else {
                            Color.clear
                        }
                    }
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .overlay(
            Group {
                if index < titles.count - 1 {
                    Rectangle()
                        .fill(dividerColor)
                        .frame(width: 1)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .allowsHitTesting(false) // разделитель не перехватывает жесты
                }
            }
        )
        .contentShape(Rectangle()) // вся область сегмента кликабельна
    }
}
