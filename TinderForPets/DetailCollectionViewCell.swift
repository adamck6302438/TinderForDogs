//
//  DetailCollectionViewCell.swift
//  TinderForPets
//
//  Created by Frances ZiyiFan on 5/23/19.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var breedLabel : UILabel!
    @IBOutlet weak var ageLabel : UILabel!
    @IBOutlet weak var genderLabel : UILabel!
    @IBOutlet weak var distanceLabel : UILabel!
    var dogInCell : Dog!
    
    func setUpCell(dog : Dog) {
        self.dogInCell = dog
        self.nameLabel.text = dog.name
//        print(nameLabel.text)
        self.breedLabel.text = dog.breed
//        print(breedLabel.text)
        self.ageLabel.text = ("\(dog.age)")
//        print(ageLabel.text)
        if(dog.isMale){
            self.genderLabel.text = "Male"
        }else{
            self.genderLabel.text = "Female"
        }
        self.distanceLabel.text = "\(dog.distance)"
    }
}
