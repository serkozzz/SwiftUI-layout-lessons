//
//  HostingConfigurationSample.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.10.2025.
//

import SwiftUI
import UIKit

//здесь только обертка чтобы показать UIKit демку в этом swiftUI проекте
//можешь вообще забыть про этот файл и смотреть только код TableVC.swift

struct HostingConfigurationSample: View {
    var body: some View {
        TableVCRepresentable()
    }
}



//нужно только для того чтобы показать UIKit демку в этом проекте.
struct TableVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        .init(rootViewController: TableVC()) }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}


#Preview {
    HostingConfigurationSample()
}
