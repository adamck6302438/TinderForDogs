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
    var color:String
    var isMale:Bool
    var distance:Int?
    var image: UIImage?
    var imageURL:String
    var safariURL:String
    var address:String
    
    init(id: String, address: String, safariURL: String, imageURL: String, name: String, breed: String, age: DogAge, size: DogSize, description: String, color: String, isMale: Bool) {
        self.identifier = id
        self.address = address
        self.name = name
        self.breed = breed
        self.age = age
        self.size = size
        self.detailDescription = description
        self.color = color
        self.isMale = isMale
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
        guard let colors = json["colors"] as? [String : Any] else { return nil }
        let color = colors["primary"] as? String ?? ""
        guard let gender = json["gender"] as? String else { return nil }
        let isMale = gender.lowercased() == "male" ? true : false
        guard let contact = json["contact"] as? [String : Any] else { return nil }
        guard let addressDictionary = contact["address"] as? [String : Any] else { return nil }
        let addressName = addressDictionary["address1"] as? String ?? "662 King St W"
        guard let cityName = addressDictionary["city"] as? String else { return nil }
        guard let stateName = addressDictionary["state"] as? String else { return nil }
        guard let countryName = addressDictionary["country"] as? String else { return nil }
        let address = addressName == "662 King St W" ? "662 King St W, Toronto, ON, Canada" : "\(addressName), \(cityName), \(stateName), \(countryName)"
        let dog = Dog(id: id, address: address, safariURL: safariURL, imageURL: imageURL, name: name, breed: breed, age: age, size: dogSize, description: description, color: color, isMale: isMale)
        LocationManager.shared.fetchDistanceFromCurrentLocationFor(dog: dog)
        NetworkManager.shared().fetchImage(for: dog)
        return dog
    }
}
