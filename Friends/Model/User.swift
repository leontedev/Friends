//
//  User.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    let id: UUID
    let name: String
    let age: Int8
    let address: String
    let about: String
    let friends: [Friend]
}
