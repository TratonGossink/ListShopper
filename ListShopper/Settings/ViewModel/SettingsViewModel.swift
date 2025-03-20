//
//  SettingsViewModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/18/25.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
}
