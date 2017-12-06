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
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var startingView: UIStackView!
    
    var myGoalsArray = [Goals]()
    
    var dateFormatter = DateFormatter()
    var daysRemaining = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        dateFormatter.dateFormat = "MMM d, yyyy"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        fetchData()
        self.homeTableView.reloadData()
    }
    
    //It will fetch Data from Core Data
    func fetchData() {
        fetchData { (parsed) in
            if parsed {
                if self.myGoalsArray.count >= 1 {
                    self.homeTableView.isHidden = false
                } else {
                    self.homeTableView.isHidden = true
                }
                
            } else {
               // Error in fetching Data.
            }
        }
    }

    @IBAction func goalButtonPressed(_ sender: UIButton) {
        
       guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {return }
        presentViewController(createGoalVC)
        
    }
    
    
    //It will return the interval between startDate and endDate.
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
    
    

}


//Table View:
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGoalsArray.count
    }
    
    //Cell for row:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as? HomeCell else {return UITableViewCell()}
        let myGoal = myGoalsArray[indexPath.row]
        daysRemaining = checkRemainingDays(goalCompletionDate: myGoal.goalCompletionDate!, goalCreatedDate: myGoal.startDateString!)
        cell.customizeView(goalDescription: myGoal.goalDescription!, goalType: myGoal.goalType!, remainingDays: daysRemaining, startDate: myGoal.startDateString!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //When user selects a row, it will be called.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "", message: "Do you wanna delete your goal?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "DELETE", style: .destructive) { (alertAction) in
            self.removeGoal(atIndexPath: indexPath, completion: { (removed) in
                if removed {
                    
                    self.fetchData()
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                    self.homeTableView.reloadData()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}


//Core Data:
extension HomeVC {
    
    //It will fetch data from Core Data Model and assign all data to myGoalsArray
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
    
    //It will remove the goal from CoreData (When user selected and removed it.)
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
    
    
}























