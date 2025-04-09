//
//  ListShopperApp.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/6/25.
//

import SwiftUI
import FirebaseCore

@main
struct ListShopperApp: App {
    
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            LogInView()
            MainView()
                .environmentObject(settingsViewModel)
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
        }
    }
}
