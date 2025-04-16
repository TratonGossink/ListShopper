//
//  UserModel.swift
//  ListShopper
//
//  Created by Traton Gossink on 3/17/25.
//

import Foundation

struct User: Codable, Observable {
    var id: String
    var name: String
    var email: String
    var joined: TimeInterval
    var photo: String?
}
 
