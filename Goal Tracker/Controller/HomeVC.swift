//
//  ViewController.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/2/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class HomeVC: UIViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var hiddenView: UIStackView!
    @IBOutlet weak var moreButton: UIButton!
    
    //HOLD THE DATA FROM CORE DATA.
    var myGoalsArray = [Goals]()
    
    var dateFormatter = DateFormatter()
    var daysRemaining = Int()
    
    var goalCompleted = UserDefaults.standard.integer(forKey: "totalGoalCompleted")
    var goalOnProgress = UserDefaults.standard.integer(forKey: "goalOnProgress")
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDeviceModel()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        addSWController()
        
    }
    
    //VIEW WILL APPEAR:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchData()
        self.homeTableView.reloadData()
    }
    
    //IT WILL CHECK THE DEVICE MODEL AND UPDATE THE TOP VIEW HEIGHT.
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
    
    
    //FETCH DATA FROM CORE DATA MODEL.
    func fetchData() {
        fetchData { (parsed) in
            if parsed {
                if self.myGoalsArray.count >= 1 {
                    self.hiddenView.isHidden = true
                    self.homeTableView.isHidden = false
                } else {
                    self.homeTableView.isHidden = true
                    self.hiddenView.isHidden = false
                }
                
            } else {
               // Error in fetching Data.
            }
        }
    }

    //GOAL BUTTON PRESSED:
    @IBAction func goalButtonPressed(_ sender: UIButton) {
        
       guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return }
        presentViewController(createGoalVC)
    }
    
    
    //RETURNS THE DAYS
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
    
    //It will compare today Date and goalCompletionDate and return us the remaining days to complete the goal.
    func checkRemainingDays(goalCompletionDate: Date, goalCreatedDate: String ) -> Int {
        
        let todayDate = Date()
        let todayDateString = dateFormatter.string(from: todayDate)
        var numberOfDays = Int()
        
        if todayDateString == goalCreatedDate {
           numberOfDays = daysBetweenDates(startDate: todayDate, endDate: goalCompletionDate)
        } else {
          numberOfDays = daysBetweenDates(startDate: todayDate, endDate: goalCompletionDate)
        }
        
        return numberOfDays
    }
    
    //WELCOME VIEW GOAL BUTTON PRESSED:
    @IBAction func hiddenViewGoalBtnPressed(_ sender: UIButton) {
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return }
        presentViewController(createGoalVC)
        
    }
    
    
}


//Home Table View:
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    //Number of rows:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myGoalsArray.count
        
    }
    
    //Cell for row:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as? HomeCell else {return UITableViewCell()}
            let myGoal = myGoalsArray[indexPath.row]
            daysRemaining = checkRemainingDays(goalCompletionDate: myGoal.goalCompletionDate!, goalCreatedDate: myGoal.startDateString!)
            cell.customizeView(goalDescription: myGoal.goalDescription!, goalType: myGoal.goalType!, remainingDays: daysRemaining, startDate: myGoal.startDateString!)
        
        if daysRemaining == 0 {
            
            UserDefaults.standard.set(goalCompleted + 1, forKey: "totalGoalCompleted")
            UserDefaults.standard.set(goalOnProgress - 1, forKey: "goalOnProgress")
            
            addCompletedGoal(goalDescription: myGoal.goalDescription!, goalType: myGoal.goalType!)
            
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { (timer) in
                self.removeGoal(atIndexPath: indexPath, completion: { (removed) in
                    if removed {
                        self.fetchData()
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        self.homeTableView.reloadData()
                    }
                })
            })
        }
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //ROW IS SELECTED.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let alert = UIAlertController(title: "", message: "Do you wanna delete your goal?", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "DELETE", style: .destructive) { (alertAction) in
                self.removeGoal(atIndexPath: indexPath, completion: { (removed) in
                    if removed {
                        
                        self.fetchData()
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                        self.homeTableView.reloadData()
                        
                        UserDefaults.standard.set(self.goalOnProgress - 1, forKey: "goalOnProgress")
                    }
                })
            }
            
            let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    
    
    }

//CORE DATA:
extension HomeVC {
    
    //FETCH DATA FROM CORE DATA MODEL:
    func fetchData(completion: @escaping (_ success: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        let fetchRequest = NSFetchRequest<Goals>(entityName: "Goals")
        
        do {
            myGoalsArray = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    //REMOVE THE GOAL FROM CORE DATA: (When user selected and removed it.)
    func removeGoal(atIndexPath index: IndexPath, completion: @escaping (_ deleted: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        
        managedContext.delete(myGoalsArray[index.row])
        
        do {
          try managedContext.save()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    
    //IT WILL SAVE COMPLETED GOALS ON CORE DATA (CompletedGoals) ENTITY.
    func addCompletedGoal(goalDescription description: String, goalType type: String) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        
        let goalCompleted = CompletedGoals(context: managedContext)
        goalCompleted.goalDescription = description
        goalCompleted.goalType = type
        
        do {
            try managedContext.save()
        } catch {
            print("Error while saving completed goals.")
        }
        
    }
    
}
























