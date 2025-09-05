//
//  UIView.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 03.09.2025.
//

import SwiftUI





struct FittingSizeUIViewSample: View {
    
    var body: some View {
        VStack {
            MyViewControllerRepresentable()
                .fixedSize()
                .background(.yellow)
            Text("SwiftUI")
        }
    }
}

#Preview {
    FittingSizeUIViewSample()
}





struct MyViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
            return MyViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}



private class MyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        preferredContentSize = stack.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

    }
    
    lazy var label1: UILabel = {
        var label = UILabel()
        label.text = "label 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var label2: UILabel = {
        var label = UILabel()
        label.text = "label 2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button1: UIButton = {
        var button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        var cfg = button.configuration
        cfg?.title = "button 1"
        button.configuration = cfg
        button.configuration = cfg
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label1, label2, button1])
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}
