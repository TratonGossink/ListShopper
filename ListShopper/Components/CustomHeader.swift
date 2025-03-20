//
//  CustomHeadre.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import SwiftUI

struct CustomHeader: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(background.opacity(0.5))
                .frame(width: 100, height: 100)
                .offset(x: -80)
                .offset(y: 150)
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 10))
                .frame(width: 100, height: 100)
                .offset(x: -20)
                .offset(y: 150)
                .foregroundStyle(Color.black.opacity(0.5))
            
            ZStack {
                Rectangle()
                    .fill(background.opacity(0.7))
                    .rotationEffect(.degrees(angle))
                    .offset(y: -50)
                
                VStack {
                    Text(title)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.system(size: 30, weight: .light))
                        .foregroundColor(.white)
                }
            }
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 30, dash: [25, 20]))
                .frame(width: 100, height: 100)
                .offset(x: 40)
                .offset(y: 150)
                .foregroundStyle(Color.black.opacity(0.3))
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -50)
    }
}

#Preview {
    CustomHeader(title: "Title", subtitle: "Subtitle", angle: 15, background: .orange)
}
