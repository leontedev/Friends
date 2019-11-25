//
//  Users.swift
//  Friends
//
//  Created by Mihai Leonte on 25/11/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

class Users: ObservableObject {
    @Published var users: [User] = []
}
