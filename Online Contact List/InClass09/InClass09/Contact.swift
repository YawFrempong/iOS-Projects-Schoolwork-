//
//  Contact.swift
//  InClass09
//
//  Created by Gupta-leary, Lukas on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import Foundation

class Contact {
    var name: String
    var email: String
    var phone: String
    var phoneType: String
    
    init(name: String, email: String, phone: String, phoneType: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneType = phoneType
    }
}
