//
//  ToastView.swift
//  ListShopper
//
//  Created by Traton Gossink on 4/28/25.
//

import SwiftUI

struct ToastView: View {
    
    let message: String
    
    var body: some View {
        
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundStyle(.white)
            .cornerRadius(10)
            .padding(.horizontal, 40)
    }
}

#Preview {
    ToastView(message: "Test Message")
}
