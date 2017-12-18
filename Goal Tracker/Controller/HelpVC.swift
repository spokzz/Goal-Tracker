//
//  HelpVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

   
    //MAIN VIEW:
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDeviceModel()
        addSWController()
      
    }
    
    //It will return the top View Height based on Device Model.
    func checkDeviceModel() {
        
        switch deviceType! {
        case "iphone 8":
            topViewHeight.constant = 70
        case "iphone 8 Plus":
            topViewHeight.constant = 70
        case "iphone X":
            topViewHeight.constant = 90
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
    
    
}











