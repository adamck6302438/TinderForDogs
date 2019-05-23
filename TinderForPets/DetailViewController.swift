//
//  DetailViewController.swift
//  TinderForPets
//
//  Created by Frances ZiyiFan on 5/23/19.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var favouriteSections = ["Super Liked", "Liked"]
    var favouriteArray = [[Dog]]()
//    var testDog = Dog.init(id: "123", name: "Dog", breed: "Lab", age: DogAge.adult, size: DogSize.extraLarge, description: "none", color: "black", isMale: true, distance: 100)
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
//        User.shared.liked.append(testDog)
//        User.shared.superLiked.append(testDog)
        
        //
        favouriteArray.append(User.shared.superLiked)
        favouriteArray.append(User.shared.liked)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //number of sections : 2
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("\(favouriteSections.count)")
        return favouriteSections.count
    }
    
    //number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(favouriteArray[section].count)")
        return favouriteArray[section].count
    }
    
    //generate custom cell for each favourite dog
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favourite", for: indexPath) as! DetailCollectionViewCell
//        let dog = favouriteArray[indexPath.section][indexPath.row]
        
//        cell.setUpCell(dog: testDog)
        
        //setup tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleDoubleTap:")))
        tapGestureRecognizer.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tapGestureRecognizer)
        
        //setup long press gesture recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector(("handleLongPress:")))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        return cell
    }
    
    class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
    {
        //MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: self.view.frame.width/2, height: self.view.frame.height/2)
        }
    }
    
    
    func handleDoubleTap(gesture : UITapGestureRecognizer){
//        let pointInCollectionView : CGPoint = gesture.location(in: self.collectionView)
//        let selectedIndexPath: IndexPath? = self.collectionView.indexPathForItem(at: pointInCollectionView)
//        let selectedCell : DetailCollectionViewCell = self.collectionView.cellForItem(at: selectedIndexPath)
        print("double tapped")
    }
    
    //handle long press
    func handleLongPress(gesture : UILongPressGestureRecognizer){
        
    }
    
}

