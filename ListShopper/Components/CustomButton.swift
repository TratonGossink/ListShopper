//
//  CustomButton.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor)
                    .frame(width: 200, height: 40)
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)
                    .bold()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    CustomButton(title: "Title", backgroundColor: .blue, textColor: .white) {
    }
}
