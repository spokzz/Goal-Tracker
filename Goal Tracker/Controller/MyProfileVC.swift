//
//  MyProfileVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var goalsCompletedLabel: UILabel!
    @IBOutlet weak var goalsOnProgressLabel: UILabel!
    @IBOutlet weak var goalsCreated: UILabel!
    
    @IBOutlet weak var editButton: customizeUIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var goalsDataView: customizeUIVIew!
    
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    
    let imagePickerVC = UIImagePickerController()
    var pickedImage: UIImage?
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()

        getDeviceModel()
        addSWController()
        
        goalsDataView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
    

    //VIEW WILL APPEAR:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        updateGoalsData()
    }
    
    //IT WILL UPDATE THE GOAL DATA: (COMPLETED, CREATED)
    func updateGoalsData() {
        
        goalsCreated.text = "\(UserDefaults.standard.integer(forKey: "totalGoalsCreated"))"
        goalsCompletedLabel.text = "\(UserDefaults.standard.integer(forKey: "totalGoalCompleted"))"
        goalsOnProgressLabel.text = "\(UserDefaults.standard.integer(forKey: "goalOnProgress"))"
        
    }

    //Gets the device Model and Update the top View Constraint based on Model.
    func getDeviceModel() {
        
        switch deviceType! {
            
        case "iphone 8 Plus":
            profileImageHeight.constant = 280
        case "iphone X":
            profileImageHeight.constant = 300
        default:
            print("nothing")
            return
        }
    }
    
    //SWREVEAL VIEW CONTROLLER:
    func addSWController() {
        moreButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    //IT WILL UPDATE THE PROFILE IMAGE AND USERNAME
    func updateUI() {
        
        //If user has already picked a name and saved it.
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            usernameLabel.text = userName
        } else {
        }
        
        //If user has already picked image before and saved it.
        if let userImage = UserDefaults.standard.data(forKey: "userProfileImage") {
            
            profileImageView.image = UIImage(data: userImage)
            
        }
        
    }
    
    //EDIT BUTTON PRESSED:
    @IBAction func editButtonPressed(_ sender: customizeUIButton) {
        
        guard let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "editProfileVC")
            as? EditProfileVC else {return}
        self.present(editProfileVC, animated: false, completion: nil)
        
    }
    
}

    




















