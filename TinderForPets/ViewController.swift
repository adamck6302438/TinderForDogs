//
//  ViewController.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-22.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var superlikeIcon: UIImageView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var nopeIcon: UIImageView!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var superlikeButton: UIButton!
    
    var networkManger = NetworkManager()
    var filterSizes = [(name: String, isSelected: Bool)]()
    var filterGenders = [(name: String, isSelected: Bool)]()
    var filterAges = [(name: String, isSelected: Bool)]()
    var filterSections = [[(name: String, isSelected: Bool)]]()
    var centerOfImageView = CGPoint.zero
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupFilterArrays()
        setupUI()
        networkManger.fetchAccessToken()
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tLocation = touches.first?.location(in: self.view) else { return }
        if view.subviews.contains(self.filterView) && !self.filterView.frame.contains(tLocation) {
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.frame.origin = CGPoint(x: -self.view.bounds.width * 2.0/3.0, y: 0)
            }) { (_) in
                self.filterView.removeFromSuperview()
            }
        }
    }
    
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .changed:
            let angleMultiplier = (self.imageViewContainer.center.x - view.center.x) / (view.frame.maxX / 2)
            let angle: CGFloat = (10.0 * .pi / 180) * angleMultiplier
            self.imageViewContainer.transform = CGAffineTransform(rotationAngle: angle)
            self.self.imageViewContainer.center = CGPoint(x: self.view.center.x + translation.x, y: self.centerOfImageView.y + translation.y)
            
            if translation.x < -(view.frame.maxX * 0.1) {
                self.nopeIcon.alpha = -(translation.x/200.0)
                self.likeIcon.alpha = 0
                self.superlikeIcon.alpha = 0
            } else if translation.x > (view.frame.maxX * 0.1){
                self.likeIcon.alpha = translation.x/200.0
                self.nopeIcon.alpha = 0
                self.superlikeIcon.alpha = 0
            }
            
            if translation.y < -(view.frame.maxY * 0.1) && translation.x > -(view.frame.maxX * 0.1) && translation.x < (view.frame.maxX * 0.1) {
                self.superlikeIcon.alpha = -(translation.y/350.0)
                self.likeIcon.alpha = 0
                self.nopeIcon.alpha = 0
            }
            
        case .ended:
            let distanceFromCenterX = (self.imageViewContainer.center.x - view.center.x) / view.frame.maxX
            let distanceFromCenterY = (self.imageViewContainer.center.y - view.center.y) / view.frame.maxY
            
            if distanceFromCenterX < -0.25 {
                
                nope()
                
            } else if distanceFromCenterX > 0.25 {
                
                like()
                
            } else if distanceFromCenterY < -0.2 {
                
                superlike()
                
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.self.imageViewContainer.center = CGPoint(x: self.view.center.x, y: self.centerOfImageView.y)
                    self.self.imageViewContainer.transform = CGAffineTransform(rotationAngle: 0)
                    self.nopeIcon.alpha = 0
                    self.likeIcon.alpha = 0
                    self.superlikeIcon.alpha = 0
                }, completion: nil)
            }
        default:
            break
        }
    }
    
    func showNextCard() {
        //TODO: Need to have more than 1 imageView on screen @ once.
        // Need to setup next card while current card is on screen.
        self.nopeIcon.alpha = 0
         self.likeIcon.alpha = 0
        self.superlikeIcon.alpha = 0
        
        self.imageViewContainer.center = CGPoint(x: self.view.center.x, y: self.centerOfImageView.y)
        self.imageViewContainer.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.imageViewContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        self.nopeButton.isEnabled = true
        self.likeButton.isEnabled = true
        self.superlikeButton.isEnabled = true
        
    }
    
    //MARK: helpers
    
    func buttonIsEnable() {
        
        self.nopeButton.isEnabled = !self.nopeButton.isEnabled
        self.likeButton.isEnabled = !self.likeButton.isEnabled
        self.superlikeButton.isEnabled = !self.superlikeButton.isEnabled
        
    }
    
    func nope() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.self.imageViewContainer.center = CGPoint(x: self.view.frame.maxX * -1.5, y: self.view.center.y)
            self.self.imageViewContainer.transform = CGAffineTransform(rotationAngle: 0)
            
        }) { (complete) in
            if complete {
                self.showNextCard()
            }
        }
    }
    
    func like() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.self.imageViewContainer.center = CGPoint(x: self.view.frame.maxX * 1.5, y: self.view.center.y)
            self.self.imageViewContainer.transform = CGAffineTransform(rotationAngle: 0)
           
        }) { (complete) in
            if complete {
                self.showNextCard()
            }
        }
    }
    
    func superlike() {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
             self.self.imageViewContainer.center = CGPoint(x: self.view.center.x, y: self.view.frame.maxY * -1.5)
            self.self.imageViewContainer.transform = CGAffineTransform(rotationAngle: 0)
            
        }) { (complete) in
            if complete {
                self.showNextCard()
            }
        }
        
        
        
    }
    
    
    //MARK: Setups
    
    func setupUI() {
        
        self.centerOfImageView = self.imageViewContainer.center
        self.likeIcon.alpha = 0
        self.nopeIcon.alpha = 0
        self.superlikeIcon.alpha = 0
        
    }
    
    func setupFilterView() {
        self.filterView.frame = CGRect(origin: CGPoint(x: -self.view.bounds.width * 2.0/3.0, y: 0), size: CGSize(width: self.view.bounds.width * 2.0/3.0, height: self.view.bounds.height))
        view.addSubview(self.filterView)
        
        UIView.animate(withDuration: 0.5) {
            self.filterView.frame.origin = CGPoint.zero
        }
    }
    
    func setupFilterArrays() {
        self.filterSizes.append((name: "Small", isSelected: false))
        self.filterSizes.append((name: "Medium", isSelected: false))
        self.filterSizes.append((name: "Large", isSelected: false))
        self.filterSizes.append((name: "Extra Large", isSelected: false))
        self.filterGenders.append((name: "Male", isSelected: false))
        self.filterGenders.append((name: "Female", isSelected: false))
        self.filterAges.append((name: "Baby", isSelected: false))
        self.filterAges.append((name: "Young", isSelected: false))
        self.filterAges.append((name: "Adult", isSelected: false))
        self.filterSections = [self.filterSizes, self.filterGenders, self.filterAges]
        self.tableView.reloadData()
    }
    
    //MARK: IBActions
    
    @IBAction func filterTapped(_ sender: Any) {
        self.setupFilterView()
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    
    @IBAction func nopeTapped(_ sender: UIButton) {
        buttonIsEnable()
        self.nopeIcon.alpha = 1
        UIView.animate(withDuration: 0.5,delay: 0.1,animations: {
            let angle: CGFloat = (10.0 * .pi / -180)
            self.imageViewContainer.transform = CGAffineTransform(rotationAngle: angle)
            self.self.imageViewContainer.center = CGPoint(x: self.view.center.x - 450, y: self.centerOfImageView.y - 250)
            
        }){ (_) in
            self.nope()
        };
        
        
        
    }
    @IBAction func superliketapped(_ sender: UIButton) {
        buttonIsEnable()
        self.superlikeIcon.alpha = 1
        UIView.animate(withDuration: 0.5,delay: 0.1 ,animations: {
            self.self.imageViewContainer.center = CGPoint(x: self.view.center.x, y: self.centerOfImageView.y - 800)
        }){ (_) in
            self.superlike()
        };

        
        
    }
    @IBAction func likeTapped(_ sender: Any) {
        self.likeIcon.alpha = 1
        buttonIsEnable()
        UIView.animate(withDuration: 0.5,delay: 0.1 ,animations: {
            let angle: CGFloat = (10.0 * .pi / 180)
            self.imageViewContainer.transform = CGAffineTransform(rotationAngle: angle)
            self.self.imageViewContainer.center = CGPoint(x: self.view.center.x + 450, y: self.centerOfImageView.y - 250)
        }){ (_) in
            self.like()
        };
    }
    
}

//MARK: Table View Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Size"
        case 1:
            return "Gender"
        case 2:
            return "Age"
        default:
            break
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.filterSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.filterSections[indexPath.section][indexPath.row].name
        cell.accessoryType = self.filterSections[indexPath.section][indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterSections[indexPath.section][indexPath.row].isSelected = !self.filterSections[indexPath.section][indexPath.row].isSelected
        self.tableView.reloadData()
    }
    
}

