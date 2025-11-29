//
//  UserProfileView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 12/11/25.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State private var isEditUserFormPresented: Bool = false
    
    @State private var isDeleteAccountAlertPresented: Bool = false
    
    init() {

        let userRespository = DIContainer.shared.getInstance(of: UserRepository.self)
        
        let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
        
        let authenticationManager = DIContainer.shared.getInstance(of: AuthenticationManager.self)
        
        let viewModel = ViewModel(
            userRepository: userRespository,
            authenticationRepository: authenticationRepository,
            autheticationManager: authenticationManager
        )
        
        self._viewModel = StateObject(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        VStack {
            
            if viewModel.isInitializing {
                
                ProgressView()
                
            } else if let user = viewModel.user {
                
                NavigationStack {
                    List{
                        
                        ListItemView(label: "Name", value: user.name)
                        
                        ListItemView(label: "Email", value: user.email)
                            
                        VStack{
                            
                            DestructiveButtonView(
                                title: "Delete Account",
                                isDisabled: viewModel.actionsDisabled,
                                onPress: { isDeleteAccountAlertPresented = true }
                            )
                            
                            
                            TextButtonView(
                                title: "Sign Out",
                                isDisabled: viewModel.actionsDisabled,
                                onPress: {
                                    viewModel.signOut()
                                }
                            )

                        }
                    }
                    .navigationTitle("User Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        
                        IconButtonView(
                            icon: "pencil",
                            isDisabled: viewModel.actionsDisabled,
                            onPress: {
                                isEditUserFormPresented = true
                            }
                        )
                        

                    }
                }
                .alertDialog(
                    title: "Delete account?",
                    message: "All your data will be permamently deleted.",
                    isPresnted: $isDeleteAccountAlertPresented,
                    confirmActionLabel: "Delete",
                    confirmActionRole: .destructive,
                    confirmAction: {
                        Task {
                            await viewModel.deleteUser()
                        }
                    },
                    dismissActionLabel: "Cancel"
                )
                .sheet(isPresented: $isEditUserFormPresented) {
                    EditUserProfileView(
                        user: user,
                        onEditingComplete: viewModel.setUser
                    )
                }
                
            } else {
                
                Text("User not found")
                
            }
            
        }
        .task {
            await viewModel.initializeUser()
        }
    }
}

#Preview {
    UserProfileView()
}
