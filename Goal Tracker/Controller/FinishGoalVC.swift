//
//  FinishGoalVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var longTermDateOptionsView: UIStackView!
    @IBOutlet weak var shortTermDateOptionsView: UIView!
    
    
    var goalDescription = String()
    var goalType = String()
    
    var dateFormatter = DateFormatter()
    var selectedDate: Date?
    
    
    //It will return us seven days from today's date.
    var sevenDaysfromNow: Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
    }
    
    //It will return us year from today's date.
    var yearFromNow: Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
    
    //It will return us 15 days from today's date.
    var day_15_FromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 15, to: Date())!
    }
    
    //It will return us a month from today's date.
    var monthFromNow: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    }
    
    //It will return us two days from today's date.
    var day_2_FromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        addSwipeGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if goalType == "Short Term" {
            datePicker.maximumDate = sevenDaysfromNow
            shortTermDateOptionsView.isHidden = false
            longTermDateOptionsView.isHidden = true
            
        } else if goalType == "Long Term" {
            datePicker.maximumDate = yearFromNow
            longTermDateOptionsView.isHidden = false
            shortTermDateOptionsView.isHidden = true
            
        }
    }
    
    //It will get data from CreateGoalVC.
    func initData(goalDescription: String, goalType type: GoalType) {
        
        self.goalDescription = goalDescription
        self.goalType = type.rawValue
        
    }
    
    //When date Picker value will be changed, it is called.
   @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    
        selectedDateLabel.isHidden = false
        selectedDate = sender.date
        selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        
    }

    //When backButton will be pressed, it will be called.
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismissViewController()
        
    }
    
    //When user pressed custom date (like 15 days or month)
    @IBAction func customButtonPressed(_ sender: UIButton) {
        
        
        switch sender.currentTitle! {
        case "15 days":
            selectedDate = day_15_FromNow
            selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        case "1 month":
            selectedDate = monthFromNow
            selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        case "2 days":
            selectedDate = day_2_FromNow
            selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        case "1 week":
            selectedDate = sevenDaysfromNow
            selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        default:
            selectedDate = datePicker.date
            selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        }
        
        selectedDateLabel.isHidden = false
        
    }
    
    //When createGoalButton will be Pressed, it will be called.
    @IBAction func createGoalButtonPressed(_ sender: UIButton) {
        
        if selectedDate != nil {
            saveData { (success) in
                if success {
                    guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") else {return }
                    self.rootVC(viewController: homeVC)
                } else {
                    print("Error in saving data.")
                }
            }
        } else {
            print("Date not selected.")
            //Do the Alert Action
        }
        
        
        
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

//Core Data: Saving Data
 extension FinishGoalVC {
        
        //It will save Data in CoreDataModel.
        func saveData(completion: @escaping (_ saved: Bool) -> ()) {
            
            let todayDate = Date()
            let todayDateString = dateFormatter.string(from: todayDate)
            
            guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
            
            let goal = Goals(context: managedContext)
            goal.goalDescription = goalDescription
            goal.goalType = goalType
            goal.startDateString = todayDateString
            goal.goalCompletionDate = selectedDate!
            
            do {
                try managedContext.save()
                completion(true)
            } catch {
                print("Error Saving Data: \(error.localizedDescription) ")
                completion(false)
            }
        }
        
    }








