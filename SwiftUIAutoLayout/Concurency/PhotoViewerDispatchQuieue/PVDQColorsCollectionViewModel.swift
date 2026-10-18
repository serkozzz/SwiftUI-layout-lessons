//
//  ColorsViewModel.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 17.10.2026.
//
import SwiftUI
import Combine

extension PhotoViewerDispatchQuieue {
    
    @MainActor
    class ColorsCollectionViewModel: ObservableObject {
        
        @Published var colors: [ColorDTO] = []
        @Published var error: ServerAPIError?
        
        let colorsService: ColorsService
        
        init(colorsService: ColorsService) {
            self.colorsService = colorsService
        }
        
        func loadColors() {
            self.colorsService.getColors() { result in
                switch result {
                case .success(let colorsDTO):
                    DispatchQueue.main.async {
                        self.colors = colorsDTO
                    }
                    
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        guard let error = error as? ServerAPIError else {
                            self.error = .unknown
                            return
                        }
                        self.error = error
                    }
                }
            }
        }
    }
}
