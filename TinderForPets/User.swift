//
//  User.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-23.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

@objcMembers class User: NSObject {

    static let shared = User()
    var allDogs = [Dog]()
    var disliked = [Dog]()
    var liked = [Dog]()
    var superLiked = [Dog]()
    
}
