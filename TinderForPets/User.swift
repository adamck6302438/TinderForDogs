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
    var filterSizes = [(name: String, isSelected: Bool)]()
    var filterGenders = [(name: String, isSelected: Bool)]()
    var filterAges = [(name: String, isSelected: Bool)]()
    var filterSections = [[(name: String, isSelected: Bool)]]()
    var allDogs = [Dog]()
    var disliked = [Dog]()
    var liked = [Dog]()
    var superLiked = [Dog]()
    
}
