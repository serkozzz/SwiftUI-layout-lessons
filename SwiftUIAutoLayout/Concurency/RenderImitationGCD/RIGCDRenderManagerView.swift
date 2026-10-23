//
//  RenderManagerView.swift
//  sandbox3
//
//  Created by Sergey Kozlov on 21.10.2026.
//

import SwiftUI
import Combine

extension RenderImitationGCD {
    struct RenderManagerView : View {
        @ObservedObject var viewModel: RenderManagerViewModel
        var body: some View {
            NavigationView {
                List {
                    ForEach(viewModel.jobs) { job in
                        RenderJobView(renderJob: job)
                        //                        .swipeActions {
                        //                            Button("Отменить") {
                        //                                viewModel.cancelJob(jobID: job.id)
                        //                            }
                        //                            .tint(.orange)
                        //                        }
                    }
                    //                .onDelete {indexes in
                    //                    viewModel.remove(indexes: indexes)
                    //                }
                }
                .navigationTitle(Text("Renders"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.addJob()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
}
