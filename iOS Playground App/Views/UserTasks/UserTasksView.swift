//
//  UserTasksView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import SwiftUI

struct UserTasksView: View {
    
    @EnvironmentObject private var userTasksCoordinator: UserTasksNavigationView.UserTasksCoordinator
    
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        
    }

    var body: some View {
        
        VStack{
            if viewModel.isFetchingTasks {
                
                ProgressView()
                
            } else {
                VStack{
                    
                    Picker("", selection: $viewModel.selectedFilter) {
                        ForEach(Filter.allCases) { filter in
                            Text(filter.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if viewModel.filteredTasks.isEmpty {
                        
                        VStack(alignment: .center){
                            
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("No tasks found for \(viewModel.searchQuery.isNotEmpty ? "'\(viewModel.searchQuery)'" : "").")
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                        
                    } else {
                        
                        List{
                            
                            ForEach(viewModel.filteredTasks) { task in
                                
                                TaskListItemView(
                                    task: task,
                                    isDisabled: viewModel.isRefreshingTasks,
                                    isCompleting: viewModel.updatingTaskIds.contains(task.id),
                                    onPress: { task in
                                        userTasksCoordinator.openSheet(for: .editTask(task: task))
                                    },
                                    
                                ) { isCompleted in
                                    viewModel.updateStatusCompleted(isCompleted, for: task)
                                }
                                
                                
                            }
                            .onDelete(perform: viewModel.deleteTask)
                            
                        }
                        .refreshable(action: viewModel.refreshTasks)
                        
                        
                    }
                }
                .alertDialog(
                    title: viewModel.errorTitile,
                    message: viewModel.errorMessage,
                    isPresnted: $viewModel.showErrorAlert,
                    confirmAction: viewModel.hideErrorMessage
                )
                .searchable(text: $viewModel.searchQuery)
                .toolbar {
                    
                    ToolbarItem(placement: .primaryAction) {
                        IconButtonView(icon: "plus") {
                            userTasksCoordinator.openSheet(for: .createTask)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                }
                .overlay(alignment: .center, content: {
                    if viewModel.isDeleting {
                        VStack{
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.3))
                        .ignoresSafeArea(.all)
                        
                    }
                })
            }
            
        }
        .navigationTitle("Tasks")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.initializeTasks()
        }
    }
}


#Preview {
    MainNavigationView.MainCoordinator().view(for: .userTasks)
}
