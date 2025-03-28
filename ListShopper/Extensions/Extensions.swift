//
//  Extensions.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return jsonData ?? [:]
        } catch {
            return [:]
        }
    }
}
    
//    extension TabBarView {
//        func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
//            HStack(alignment: .center,spacing: 22){
//                Spacer()
//                Image(imageName)
//                    .resizable()
//                    .renderingMode(.template)
//                    .foregroundColor(isActive ? .purple : .gray)
//                    .frame(width: 25, height: 25)
//                Spacer()
//            }
//        }
//    }
    
