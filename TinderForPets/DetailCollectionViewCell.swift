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
        self.imageView.image = dog.image
        self.nameLabel.text = dog.name
        self.breedLabel.text = dog.breed
        self.ageLabel.text = ("\(dog.age)")
        if(dog.gender == "male"){
            self.genderLabel.text = "Male"
        }else{
            self.genderLabel.text = "Female"
        }
        self.distanceLabel.text = dog.distance
    }
}
