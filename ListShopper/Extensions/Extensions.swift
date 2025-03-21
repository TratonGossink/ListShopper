//
//  Extensions.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
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
//    extension Encodable {
//        func asDictionary() throws -> [String: Any] {
//            let data = try JSONEncoder().encode(self)
//            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//            guard let dictionary = json as? [String: Any] else {
//                throw NSError(domain: "asDictionary", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON to dictionary"])
//            }
//            return dictionary
//        }
//    }
    
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
    
