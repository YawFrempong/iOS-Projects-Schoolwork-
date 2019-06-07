//
//  Comment.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/3/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import Foundation

class Comment {
    var userID: String
    var message: String
    var name: String
    
    init(userID: String, message: String, name: String) {
        self.userID = userID
        self.message = message
        self.name = name
    }
}
