//
//  HistoryVC.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/11/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit
import CoreData

class HistoryVC: UIViewController {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var completedGoalTableView: UITableView!
    @IBOutlet weak var noGoalDisplayView: UIView!
    
    var goalsCompletedArray = [CompletedGoals]()
    
    //VIEW DID LOAD:
    override func viewDidLoad() {
        super.viewDidLoad()

        addSWController()
        checkDeviceModel()
        completedGoalTableView.delegate = self
        completedGoalTableView.dataSource = self
    }
    
    //VIEW WILL APPEAR:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchdata { (success) in
            
            if self.goalsCompletedArray.isEmpty {
                self.noGoalDisplayView.isHidden = false
                self.completedGoalTableView.isHidden = true
            } else {
                self.noGoalDisplayView.isHidden = true
                self.completedGoalTableView.isHidden = false
            }
            
            self.completedGoalTableView.reloadData()
        }
    }

    //SWREVEAL VIEW CONTROLLER:
    func addSWController() {
        moreButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
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
    
    //FETCH DATA FROM CORE DATA:
    func fetchdata(completion: @escaping (_ fetched: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<CompletedGoals>(entityName: "CompletedGoals")
        
        do {
           goalsCompletedArray = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            completion(false)
        }
    }
 

}

//UITABLEVIEW DELEGATE:
extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsCompletedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "completedGoalsCell", for: indexPath) as? CompletedGoalsCell else {return UITableViewCell()}
        cell.configureCell(completedGoal: goalsCompletedArray[indexPath.row])
        return cell
    }
    
    
}




















