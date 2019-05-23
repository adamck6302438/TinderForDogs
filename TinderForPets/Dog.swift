//
//  Dog.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-23.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

enum DogSize: String {
    case small, medium, large, extraLarge
}

enum DogAge: String {
    case baby, young, adult
}

@objcMembers class Dog: NSObject {
    
    var identifier:String
    var name:String
    var breed:String
    var age:DogAge
    var size:DogSize
    var detailDescription:String
    var color:String
    var isMale:Bool
    var distance:Int
    
    init(id: String, name: String, breed: String, age: DogAge, size: DogSize, description: String, color: String, isMale: Bool, distance: Int) {
        self.identifier = id
        self.name = name
        self.breed = breed
        self.age = age
        self.size = size
        self.detailDescription = description
        self.color = color
        self.isMale = isMale
        self.distance = distance
    }
    
    class func initWithJSON(json: [String:Any]) -> Dog {
        return Dog(id: "", name: "", breed: "", age: .baby, size: .large, description: "", color: "", isMale: true, distance: 1)
    }

}
