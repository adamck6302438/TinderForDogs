//
//  DetailViewController.swift
//  TinderForPets
//
//  Created by Frances ZiyiFan on 5/23/19.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController{
    
    var favouriteSections = ["Super Liked", "Liked"]
    var favouriteArray = [[Dog]]()
    var urlString : String = ""
    var flowLayout: UICollectionViewFlowLayout!
    var longPressGestureRecognizer : UILongPressGestureRecognizer!
    @IBOutlet weak var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteArray.append(User.shared.superLiked)
        favouriteArray.append(User.shared.liked)
        setupFlowLayout()
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(moveCell(sender:)))
        collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func setupFlowLayout() {
        
        self.flowLayout =  self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        self.flowLayout.minimumInteritemSpacing = 8
        let width = CGFloat.init( (self.view.frame.width - 8) / 2.0)
        let height = CGFloat.init(width * (4.0/3.0))
        self.flowLayout.itemSize = CGSize.init(width: width, height: height)
        
    }
    
    @IBAction func back(_ sender: Any) {
        favouriteArray.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func doubleTap(sender : UITapGestureRecognizer) {
        let touch = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: touch){
            if indexPath.section == 0 {
                User.shared.superLiked.remove(at: indexPath.row)
                favouriteArray[0].remove(at: indexPath.row)
            }else{
                User.shared.liked.remove(at: indexPath.row)
                favouriteArray[1].remove(at: indexPath.row)
            }
        }
        collectionView.reloadData()
    }
    
    @objc func singleTap(sender : UITapGestureRecognizer) {
        let touch = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: touch){
            let dog = favouriteArray[indexPath.section][indexPath.row]
            self.urlString = dog.safariURL
            openURL(_sender: self)
        }
    }
    
    @objc func moveCell(sender : UILongPressGestureRecognizer){
        switch sender.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    @IBAction func openURL(_sender: Any){
        guard let url = URL(string: "\(self.urlString)") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate {
    
    //number of sections : 2
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return favouriteSections.count
    }
    
    //number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteArray[section].count
    }
    
    //generate custom cell for each favourite dog
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favourite", for: indexPath) as! DetailCollectionViewCell
        let dog = favouriteArray[indexPath.section][indexPath.row]
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        cell.addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(sender:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.require(toFail: doubleTap)
        cell.addGestureRecognizer(singleTap)
        cell.setUpCell(dog: dog)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderCollectionReusableView{
            sectionHeader.sectionHeaderLabel.text = "\(favouriteSections[indexPath.section])"
            return sectionHeader
        }
        return UICollectionReusableView()
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dog = favouriteArray[sourceIndexPath.section][sourceIndexPath.row]
        let cell = favouriteArray[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        favouriteArray[destinationIndexPath.section].insert(cell, at: destinationIndexPath.item)
        if(sourceIndexPath.section == 0){
            User.shared.superLiked.remove(at: sourceIndexPath.row)
            if(destinationIndexPath.section == 0){
                User.shared.superLiked.insert(dog, at: destinationIndexPath.row)
            }else{
                User.shared.liked.insert(dog, at: destinationIndexPath.row)
            }
        }else if(sourceIndexPath.section == 1){
            User.shared.liked.remove(at: sourceIndexPath.row)
            if(destinationIndexPath.section == 0){
                User.shared.superLiked.insert(dog, at: destinationIndexPath.row)
            }else{
                User.shared.liked.insert(dog, at: destinationIndexPath.row)
            }
        }
        
    }
}

