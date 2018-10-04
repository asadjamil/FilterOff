//
//  User.swift
//  FilterOff
//
//  Created by Asad Jamil on 5/3/18.
//  Copyright © 2018 Asad Jamil. All rights reserved.
//

import Foundation
class User: NSObject, Codable
{
    var name: String = ""
    var age: Int = 0
    var gender: String = ""
    var email: String = ""
    var facebookID: String = ""
    var profileImageURL: String = ""
    var facebookToken: String = ""
}
