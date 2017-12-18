//
//  HomeCell.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

//HOME TABLE VIEW CELL:
class HomeCell: UITableViewCell {

    @IBOutlet weak var dataView: customizeUIVIew!
    @IBOutlet weak var goalCompletedView: customizeUIVIew!
    
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var remainingDays: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var startingDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataView.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
    }
    
    func customizeView(goalDescription description: String, goalType type: String, remainingDays days: Int, startDate: String) {
        
        self.goalDescription.text = description
        self.goalType.text = type
        self.remainingDays.text = "\(days)"
        self.daysLeftLabel.text = "days left"
        self.startingDate.text = startDate
        
        //It will decide when to display Goal Completed View.
        if days != 0 {
            dataView.isHidden = false
            startingDate.isHidden = false
            goalCompletedView.isHidden = true
            
        } else {
            goalCompletedView.isHidden = false
            dataView.isHidden = true
            startingDate.isHidden = true
            
            //it will show the completed goal for 2 second.
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                print("Dismiss")
                self.goalCompletedView.isHidden = true
                self.dataView.isHidden = false
            })
        }
        
    }
    
    

}
