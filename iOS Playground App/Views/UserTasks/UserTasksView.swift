//
//  UserTasksView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import SwiftUI

struct UserTasksView: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State private var taskInEdit: UserTask? = nil
    @State private var isCreateTaskFormPresent: Bool = false
   
    init() {
        
        let taskRepository = DIContainer.shared.getInstance(of: TasksRepository.self)
        //let userId = DIContainer.shared.getInstance(of: AuthenticationManager.self).userId!
        let userId = AppConstants.MOCK_USER_ID // TODO: Preview only!
        
        self._viewModel = StateObject(wrappedValue: ViewModel(
            userId: userId,
            tasksRepository: taskRepository
        ))
        
    }

    var body: some View {
        
        NavigationStack{
            
            VStack{
                if viewModel.isFetchingTasks {
                    
                    ProgressView()
                    
                } else {
                    VStack{
                        
                        if viewModel.filteredTasks.isEmpty {
                            
                            VStack{
                                
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                if viewModel.searchQuery.isNotEmpty {
                                    Text("No results found for '\(viewModel.searchQuery)'.")
                                } else {
                                    Text("No tasks found.")
                                }
                                
                            }
                            
                            
                        } else {
                            
                            List{
                                
                                ForEach($viewModel.filteredTasks) { task in
                                    
                                    TaskListItemView(
                                        task: task,
                                        isDisabled: viewModel.isRefreshingTasks,
                                        isCompleting: viewModel.updatingTaskIds.contains(task.id),
                                        onPress: { task in
                                            self.taskInEdit = task
                                        },
                                        
                                    ) { isCompleted in
                                        viewModel.updateStatusCompleted(isCompleted, for: task.wrappedValue)
                                    }
                                    
                                    
                                }
                                .onDelete(perform: viewModel.deleteTask)
                                
                            }
                            .refreshable(action: viewModel.refreshTasks)
                            .sheet(isPresented: $isCreateTaskFormPresent, content: {
                                CreateUserTaskView { _ in
                                    Task{
                                        await viewModel.refreshTasks()
                                    }
                                }
                            })
                            .sheet(item: $taskInEdit) { userTask in
                                
                                EditUserTaskView(
                                    task: userTask
                                ) { updatedTask in
                                    Task {
                                        await viewModel.refreshTasks()
                                    }
                                }
                                
                            }
                            
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
                                self.isCreateTaskFormPresent = true
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
        }
        .task {
            await viewModel.initializeTasks()
        }
    }
}


#Preview {
    UserTasksView()
}
