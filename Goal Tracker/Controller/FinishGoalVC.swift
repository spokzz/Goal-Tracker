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

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var longTermDateOptionsView: UIStackView!
    @IBOutlet weak var shortTermDateOptionsView: UIView!
    
    @IBOutlet weak var calendarView: customizeUIVIew!
    
    var goalsCreated = UserDefaults.standard.integer(forKey: "totalGoalsCreated")
    var goalOnProgress = UserDefaults.standard.integer(forKey: "goalOnProgress")
    
    var goalDescription = String()
    var goalType = String()
    
    var dateFormatter = DateFormatter()
    var selectedDate: Date?
    
    
    //RETURN (7)
    var sevenDaysfromNow: Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
    }
    
    //RETURN (365) OR (year)
    var yearFromNow: Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
    
    //RETURN (15)
    var day_15_FromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 15, to: Date())!
    }
    
    //RETURN MONTH
    var monthFromNow: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: Date())!
    }
    
    //RETURN (2)
    var day_2_FromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    }
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDeviceModel()

        datePicker.minimumDate = Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        addSwipeGesture()
        
        calendarView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
    }
    
    //VIEW WILL APPEAR:
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
    
    //GETS THE DEVICE MODEL AND UPDATE THE TOP VIEW CONSTRATINT.
    func getDeviceModel() {
        
        switch deviceType! {
        case "iphone 8":
            topViewHeight.constant = 70
            calendarViewHeight.constant = 250
        case "iphone 8 Plus":
            topViewHeight.constant = 70
        case "iphone X":
            topViewHeight.constant = 90
        default:
            print("nothing")
            return
        }
        
    }
    
    //GET DATA FROM CREATEGOALVC
    func initData(goalDescription: String, goalType type: GoalType) {
        
        self.goalDescription = goalDescription
        self.goalType = type.rawValue
        
    }
    
    //DATE PICKER VALUE IS CHANGED:
   @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    
        selectedDateLabel.textColor = #colorLiteral(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        selectedDate = sender.date
        selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: selectedDate!))"
        
    }

    //BACK BUTTON PRESSED:
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismissViewController()
        
    }
    
    //USER CHOOSE CUSTOM DATE: (shortcut button like 2 days or 1 month. )
    @IBAction func customButtonPressed(_ sender: UIButton) {
        
        selectedDateLabel.textColor = #colorLiteral(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        
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
    
    
    //CREATE GOAL BUTTON PRESSED:
    @IBAction func createGoalButtonPressed(_ sender: UIButton) {
        
        if selectedDate != nil && selectedDateLabel.text != "Selected Date: \(dateFormatter.string(from: Date()))" {
            saveData { (success) in
                if success {
                   
                    guard let swRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") else {return }
                    self.present(swRevealViewController, animated: false, completion: nil)
                    
                    UserDefaults.standard.set(self.goalsCreated + 1, forKey: "totalGoalsCreated")
                    UserDefaults.standard.set(self.goalOnProgress + 1, forKey: "goalOnProgress")
                    
                } else {
                    print("Error in saving data.")
                }
            }
        } else {
            addAlert()
        }
    }
    
    //ADD ALERT (if user didn't select a date.)
    func addAlert() {
        
        let alert = UIAlertController(title: nil, message: "Till which date you wanna do your goal?", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Choose a Date", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    //ADD SWIPE GESTURE (RIGHT)
    func addSwipeGesture() {
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swippedRightOnScreen))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    //USER SWIPPED ON A SCREEN
    @objc func swippedRightOnScreen() {
        dismissViewController()
    }
    
    
    
}

//CORE DATA:
//SAVING DATA:
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



