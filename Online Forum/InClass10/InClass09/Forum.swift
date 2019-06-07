//
//  Forum.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 4/3/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import Foundation
import Firebase

class Forum {
    var userID: String
    var likes: [String:Bool]
    var message: String
    var name: String
    var timestamp: Timestamp
    
    init(userID: String, likes: [String:Bool], message: String, name: String, timestamp: Timestamp) {
        self.userID = userID
        self.likes = likes
        self.message = message
        self.name = name
        self.timestamp = timestamp
    }
}
