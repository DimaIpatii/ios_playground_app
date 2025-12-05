//
//  UserProfileView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 12/11/25.
//

import SwiftUI

struct UserProfileView: View {
    
    @EnvironmentObject private var rootCoordinator: RootCoordinator
    @EnvironmentObject private var userProfileCoordinator: UserProfileNavigationView.UserProfileCoordinator
    
    @StateObject private var viewModel: ViewModel
    
    @State private var isEditUserFormPresented: Bool = false
    
    @State private var isDeleteAccountAlertPresented: Bool = false
    
    init(viewModel: ViewModel) {
 
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
                                    viewModel.signOut(onComplete: rootCoordinator.startAuthentication)
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
                                userProfileCoordinator.openSheet(for: .editUserProfile(user))
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
                        viewModel.deleteUser(onSuccess: rootCoordinator.startAuthentication)
                    },
                    dismissActionLabel: "Cancel"
                )
                
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
    UserProfileNavigationView.UserProfileCoordinator().view(for: .userProfile)
}
