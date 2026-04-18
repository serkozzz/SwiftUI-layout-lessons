//
//  AIRoomScreen.swift
//  RoomAIStandalone
//
//  Created by Sergey Kozlov on 10.02.2026.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct ActiveSheetEnumView: View {
    
    enum SheetResult {
        case sheet1(String)
        case sheet2
        case sheet3
        case sheet4(UIImage)
    }
    
    enum ActiveSheet: Int, Identifiable {
        case sheet1
        case sheet2
        case sheet3
        case sheet4
        var id: Int { rawValue }
    }
    
    @State private var sheetResult: SheetResult?
    @State private var activeSheet: ActiveSheet?
    @State var errorToShow: UIError?
    

    var body: some View {

            
        Color.green
        .alert(item: $errorToShow) { err in
            Alert(
                title: Text("Error"),
                message: Text(err.message),
                dismissButton: .cancel(Text("OK"))
            )
        }
        .sheet(item: $activeSheet, onDismiss: {
            defer {
                self.sheetResult = nil
            }
            switch sheetResult {
            case .sheet1(let userText):
                print("sheet1 view dismissed, userText = \(userText)")

            case .sheet2:
                print("sheet2 dismissed")
            case .sheet3:
                print("sheet3 dismissed")
            case .sheet4(_):
                print("sheet4 dismissed")
            case .none:
                return
            }
            
        }) { activeSheet in
            
            switch activeSheet {
            case .sheet1:
                ActiveSheetExampleChildView(onFinished: { userText in
                    self.sheetResult = .sheet1(userText)
                    self.activeSheet = nil
                })
            case .sheet2:
                Text("sheet2 view")
            case .sheet3:
                Text("sheet3 view")
            case .sheet4:
                Text("sheet4 view")
            }
        }

        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    activeSheet = .sheet1
                }
                label: {
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Button {
                    activeSheet = .sheet2
                }
                label: {
                    Image(systemName: "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    activeSheet = .sheet3
                }
                label: {
                    Text("sheet3")
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    activeSheet = .sheet4
                }
                label: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

