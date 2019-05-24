//
//  ContainerView.swift
//  TinderForPets
//
//  Created by Dayson Dong on 2019-05-24.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    @IBOutlet weak var superlikeIcon: UIImageView!
    @IBOutlet weak var nopeIcon: UIImageView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setAlphaZero()  {
        self.nopeIcon.alpha = 0
        self.superlikeIcon.alpha = 0
        self.likeIcon.alpha = 0

    }
    

}
