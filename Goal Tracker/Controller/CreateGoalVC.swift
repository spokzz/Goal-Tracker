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
        changeButtonColor(buttonPressed: shortTermButton)
        nextButton.bindToKeyboard()

    }
    
    @IBAction func shortTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .shortTerm
        changeButtonColor(buttonPressed: shortTermButton)
        
    }
    
    @IBAction func longTermButtonPressed(_ sender: customizeUIButton) {
        
        goalTypeSelected = .longTerm
        changeButtonColor(buttonPressed: longTermButton)
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if goalDescriptionTextView.text != "" && goalDescriptionTextView.text != "What's your goal?" {
            
           guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {return }
            finishGoalVC.initData(goalDescription: goalDescriptionTextView.text!, goalType: goalTypeSelected)
            present(finishGoalVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //It will change the button based on the user Selection.
    func changeButtonColor(buttonPressed: UIButton) {
        
        if buttonPressed == shortTermButton {
            self.shortTermButton.firstColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1)
            self.shortTermButton.secondColor = #colorLiteral(red: 0.4215020537, green: 0.5612378716, blue: 0.9383363724, alpha: 1)
            self.longTermButton.firstColor = UIColor.clear
            self.longTermButton.secondColor = UIColor.clear
            self.longTermButton.backgroundColor = #colorLiteral(red: 0.4215020537, green: 0.5612378716, blue: 0.9383363724, alpha: 1)
        }
        
        else if buttonPressed == longTermButton {
            self.longTermButton.firstColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1)
            self.longTermButton.secondColor = #colorLiteral(red: 0.4215020537, green: 0.5612378716, blue: 0.9383363724, alpha: 1)
            self.shortTermButton.firstColor = UIColor.clear
            self.shortTermButton.secondColor = UIColor.clear
            self.shortTermButton.backgroundColor = #colorLiteral(red: 0.4215020537, green: 0.5612378716, blue: 0.9383363724, alpha: 1)
        }
    }
    
    

}

extension CreateGoalVC: UITextViewDelegate {
    
    //When user press the text Field: 
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalDescriptionTextView.text = ""
        goalDescriptionTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    
}






