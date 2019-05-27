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
    case baby, young, adult, senior
}

@objcMembers class Dog: NSObject {
    
    var identifier:String
    var name:String
    var breed:String
    var age:DogAge
    var size:DogSize
    var detailDescription:String
    var gender:String
    var distance:String = "Unknown"
    var image: UIImage?
    var imageURL:String
    var safariURL:String
    var address:String
    
    init(id: String, address: String, safariURL: String, imageURL: String, name: String, breed: String, age: DogAge, size: DogSize, description: String, isMale: String) {
        self.identifier = id
        self.address = address
        self.name = name
        self.breed = breed
        self.age = age
        self.size = size
        self.detailDescription = description
        self.gender = isMale
        self.imageURL = imageURL
        self.safariURL = safariURL
    }
    
    class func initWithJSON(json: [String:Any]) -> Dog? {
        guard let idAsInt = json["id"] as? Int else { return nil }
        let id = String(idAsInt)
        guard let photos = json["photos"] as? [[String: Any]] else { return nil }
        guard let photosDict = photos.first else { return nil }
        guard let imageURL = photosDict["large"] as? String else { return nil }
        guard let safariURL = json["url"] as? String else { return nil }
        guard let name = json["name"] as? String else { return nil }
        guard let breeds = json["breeds"] as? [String:Any] else { return nil }
        guard let breed = breeds["primary"] as? String else { return nil }
        guard let ageAsString = json["age"] as? String else { return nil }
        guard let age = DogAge.init(rawValue: ageAsString.lowercased()) else { return nil }
        guard let size = json["size"] as? String else { return nil }
        guard let dogSize = DogSize.init(rawValue: size.lowercased()) else { return nil }
        let description = json["description"] as? String ?? ""
        guard let gender = json["gender"] as? String else { return nil }
        let isMale = gender.lowercased() == "male" ? "male" : "female"
        guard let contact = json["contact"] as? [String : Any] else { return nil }
        guard let addressDictionary = contact["address"] as? [String : Any] else { return nil }
        guard let postcode = addressDictionary["postcode"] as? String else { return nil}

        let dog = Dog(id: id, address: postcode, safariURL: safariURL, imageURL: imageURL, name: name, breed: breed, age: age, size: dogSize, description: description, isMale: isMale)
        LocationManager.shared.fetchDistanceFromCurrentLocationFor(dog: dog)
        
        if User.shared.dogsBlackListIndentifiers.contains(dog.identifier) {
            return nil
        } else {
            User.shared.dogsBlackListIndentifiers.append(dog.identifier)
            return dog
        }
        
    }
    
}
