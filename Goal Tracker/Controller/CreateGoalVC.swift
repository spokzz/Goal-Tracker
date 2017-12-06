//
//  CreateGoalVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalDescriptionTextView: UITextView!
    @IBOutlet weak var shortTermButton: customizeUIButton!
    @IBOutlet weak var longTermButton: customizeUIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    //When view will load, it will be selected to short Term Button.
    var goalTypeSelected: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalDescriptionTextView.delegate = self
        nextButton.bindToKeyboard()
        addSingleTap()
        addSwipeGesture()

    }
    
    //When Short Term Button is Pressed:
    @IBAction func shortTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .shortTerm
    }

    //When Long Term Button is Pressed:
    @IBAction func longTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .longTerm
    }
    
    //When NEXT button is pressed:
    @IBAction func nextButtonPressed(_ sender: customizeUIButton) {
        
        if goalDescriptionTextView.text != "" && goalDescriptionTextView.text != "What's your goal?" {
            
           guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {return }
            finishGoalVC.initData(goalDescription: goalDescriptionTextView.text!, goalType: goalTypeSelected)
            presentViewController(finishGoalVC)
        }
        
    }
    
    //When Back Button is Pressd:
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismissViewController()
    }
    
    //It will add a tap Gesture on Main View. (single Tap)
    func addSingleTap() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnSingleTap))
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        
    }
    
    //It is called when user taps on a screen.
    @objc func dismissKeyboardOnSingleTap() {
        goalDescriptionTextView.resignFirstResponder()
    }
    
    //It will add swipe gesture on main screen (right)
    func addSwipeGesture() {
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swippedLeftOnScreen))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    //It will called when user swipped on a screen
    @objc func swippedLeftOnScreen() {
        dismissViewController()
    }

}

extension CreateGoalVC: UITextViewDelegate {
    
    //When user press the text Field: 
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTextView.text = ""
        goalDescriptionTextView.textColor = #colorLiteral(red: 0.09411764706, green: 0.09803921569, blue: 0.09803921569, alpha: 1)
        
    }
    
    
}






