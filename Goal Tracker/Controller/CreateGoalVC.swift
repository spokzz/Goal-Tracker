//
//  CreateGoalVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var goalDescriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: customizeUIButton!
    @IBOutlet weak var longTermButton: customizeUIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var GoalTextBackgroundView: customizeUIVIew!
    
    var goalTypeSelected: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         getDeviceModel()
        
        goalDescriptionTextView.delegate = self
        addSingleTap()
        addSwipeGesture()
        
        GoalTextBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)

    }
    
    func getDeviceModel() {
        
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
    
    //SHORT TERM BUTTON PRESSED:
    @IBAction func shortTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .shortTerm
    }

    //LONG TERM BUTTON PRESSED:
    @IBAction func longTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .longTerm
    }
    
    //NEXT BUTTON PRESSED:
    @IBAction func nextButtonPressed(_ sender: customizeUIButton) {
        
        if goalDescriptionTextView.text != "" && goalDescriptionTextView.text != "What's your goal?" {
            
           guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {return }
            finishGoalVC.initData(goalDescription: goalDescriptionTextView.text!, goalType: goalTypeSelected)
            presentViewController(finishGoalVC)
        }
        
    }
    
    //BACK BUTTON PRESSED:
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismissViewController()
    }
    
    //ADD A TAP GESTURE. (single Tap)
    func addSingleTap() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        
    }
    
    //USER TAPPED ON A SCREEN
    @objc func dismissKeyboardOnSingleTap() {
        goalDescriptionTextView.resignFirstResponder()
    }
    
    //ADD SWIPE GESTURE (right)
    func addSwipeGesture() {
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swippedLeftOnScreen))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    //USER SWIPPED ON SCREEN.
    @objc func swippedLeftOnScreen() {
        dismissViewController()
    }

}

extension CreateGoalVC: UITextViewDelegate {
    
    //WHEN TEXT VIEW IS PRESSED:
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTextView.text = ""
        goalDescriptionTextView.textColor = #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
        
    }
    
    //DISMISS THE KEYBOARD WITH DONE BUTTON.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            goalDescriptionTextView.resignFirstResponder()
        }
        return true
    }
    
    
    
}






