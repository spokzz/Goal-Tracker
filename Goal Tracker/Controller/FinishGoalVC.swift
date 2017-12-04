//
//  FinishGoalVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var goalDescription = String()
    var goalType = String()
    
    //It will return us seven days from today's date.
    var sevenDaysfromNow: Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
    }
    
    //It will return us year from today's date.
    var yearFromNow: Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = Date()
        
        //2 days left (show it in home.)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if goalType == "Short Term" {
            datePicker.maximumDate = sevenDaysfromNow
        } else if goalType == "Long Term" {
            datePicker.maximumDate = yearFromNow
        }
    }
    
    //It will get data from CreateGoalVC.
    func initData(goalDescription: String, goalType type: GoalType) {
        
        self.goalDescription = goalDescription
        self.goalType = type.rawValue
        
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createGoalButtonPressed(_ sender: UIButton) {
        
        //We add data in coreData from here.
        print("Goal Description: \(goalDescription)")
        print("Goal Type:\(goalType)")
        print("Date:\(datePicker.date)")
        
    }
    
}







