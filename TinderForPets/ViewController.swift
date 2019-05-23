//
//  ViewController.swift
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-22.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var nopeIcon: UIImageView!
    @IBOutlet weak var likeIcon: UIImageView!
    
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
            let angleMultiplier = (self.imageView.center.x - view.center.x) / (view.frame.maxX / 2)
            let angle: CGFloat = (10.0 * .pi / 180) * angleMultiplier
            self.imageView.transform = CGAffineTransform(rotationAngle: angle)
            self.self.imageView.center = CGPoint(x: self.view.center.x + translation.x, y: self.centerOfImageView.y + translation.y)
            
            if translation.x < 0 {
                self.nopeIcon.alpha = -(translation.x/100.0)
            } else if translation.x > 0 {
                self.likeIcon.alpha = translation.x/100.0
            }
            
        case .ended:
            let distanceFromCenterX = (self.imageView.center.x - view.center.x) / view.frame.maxX
            if distanceFromCenterX < -0.25 {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.self.imageView.center = CGPoint(x: self.view.frame.maxX * -1.5, y: self.view.center.y)
                    self.self.imageView.transform = CGAffineTransform(rotationAngle: 0)
                }) { (complete) in
                    if complete {
                        self.showNextCard()
                    }
                }
            } else if distanceFromCenterX > 0.25 {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.self.imageView.center = CGPoint(x: self.view.frame.maxX * 1.5, y: self.view.center.y)
                    self.self.imageView.transform = CGAffineTransform(rotationAngle: 0)
                }) { (complete) in
                    if complete {
                        self.showNextCard()
                    }
                }
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.self.imageView.center = CGPoint(x: self.view.center.x, y: self.centerOfImageView.y)
                    self.self.imageView.transform = CGAffineTransform(rotationAngle: 0)
                }, completion: nil)
            }
        default:
            break
        }
    }
    
    func showNextCard() {
        //TODO: Need to have more than 1 imageView on screen @ once.
        // Need to setup next card while current card is on screen.
        self.imageView.center = CGPoint(x: self.view.center.x, y: self.centerOfImageView.y)
        self.imageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)

        
        
    }
    
    
    //MARK: Setups
    
    func setupUI() {
        
        self.centerOfImageView = self.imageView.center
        self.likeIcon.alpha = 0
        self.nopeIcon.alpha = 0
        
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

