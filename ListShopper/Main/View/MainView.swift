//
//  MainView.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/6/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                accountView
            } else {
                LogInView()
            }
        }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ShoppingListView(itemId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainView()
}
