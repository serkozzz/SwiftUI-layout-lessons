//
//  TableViewController.swift
//  SwiftUIAutoLayout
//
//  Created by Sergey Kozlov on 09.10.2025.
//

import UIKit
import SwiftUI
import Combine

//пример двустороннего биндинга. По сути всё просто, точно также как с обычным
//UIHostingController. чтобы уведомить из swiftUI, внешний код подписывается на методы или выставляет себя делегатом.
//Чтобы передать из внешнего UIKit внутрь - через модель. (также как и если бы свифтUI не было воовсе, vc обычно не модифицирует свой дочерний vc)

// MARK: - Observable модель для связи SwiftUI ↔ UIKit
final class TextModel: ObservableObject {
    @Published var text: String = ""
}

// MARK: - SwiftUI View для ячейки
struct TextFieldCellView: View {
    @ObservedObject var model: TextModel
    var onConfirm: (String) -> Void

    var body: some View {
        HStack {
            TextField("Enter text", text: $model.text)
                .textFieldStyle(.roundedBorder)

            Button("OK") {
                onConfirm(model.text) // 👉 Передаём значение в UIKit
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
    }
}

// MARK: - UIKit TableViewController
final class TableVC: UITableViewController {

    private let model = TextModel()
    private let floatingButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit ↔ SwiftUI"
    }

    // Таблица с одной ячейкой
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // ✅ Встраиваем SwiftUI View через UIHostingConfiguration
        let config = UIHostingConfiguration {
            TextFieldCellView(model: model) { [weak self] text in
                self?.showAlert(text: text)
            }
        }
        .background(Color.clear)

        let cell = UITableViewCell()
        cell.contentConfiguration = config
        return cell
    }

    // Дополнительная кнопка в навигации — изменить текст из UIKit
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Set 'uikit'",
            style: .plain,
            target: self,
            action: #selector(updateFromUIKit)
        )
    }

    @objc private func updateFromUIKit() {
        model.text = "uikit"
    }

    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Got from SwiftUI", message: text, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


#Preview {
    HostingConfigurationSample()
}

