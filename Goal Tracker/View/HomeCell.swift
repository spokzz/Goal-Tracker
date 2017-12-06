//
//  HomeCell.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

//It's a custom table view Cell of homeTableView.
class HomeCell: UITableViewCell {

    //View Outlets:
    @IBOutlet weak var dataView: customizeUIVIew!
    @IBOutlet weak var goalCompletedView: customizeUIVIew!
    
    //Outlets:
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var remainingDays: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var startingDate: UILabel!
    
    func customizeView(goalDescription description: String, goalType type: String, remainingDays days: Int, startDate: String) {
        
        self.goalDescription.text = description
        self.goalType.text = type
        self.remainingDays.text = "\(days)"
        self.daysLeftLabel.text = "days left"
        self.startingDate.text = startDate
        
        //It will decide when to display Goal Completed View.
        if days != 0 {
            dataView.isHidden = false
            goalCompletedView.isHidden = true
        } else {
            goalCompletedView.isHidden = false
            dataView.isHidden = true
        }
        
    }
    
    

}
