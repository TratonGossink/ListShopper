//
//  LaunchScreen.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/6/25.
//

import SwiftUI

struct LaunchScreen: View {
    @State var mainScreen: Bool = false
    @State var scaleAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            if mainScreen {
                MainView()
            } else {
                Image("logo-screen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaleAmount)
                    .frame(width: 80)
            }
        }
        .onAppear {
            //MARK: - Shrink opening image
            withAnimation(.easeOut(duration: 0.75)) {
                scaleAmount = 0.6
            }
            //MARK: - Enlarge opening image
            withAnimation(.easeInOut(duration: 1).delay(1)) {
                scaleAmount = 50
            }
            //MARK: - Changes to main screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                mainScreen = true
            }
        }
        
    }
}

#Preview {
    LaunchScreen()
}
