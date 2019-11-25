//
//  Friend.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

struct Friend: Codable, Hashable {
    let id: UUID
    let name: String
}
