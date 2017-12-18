//
//  CompletedGoalsCell.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/12/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

//COMPLETED GOALS TABLE VIEW CELL:

class CompletedGoalsCell: UITableViewCell {

    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    @IBOutlet weak var dataView: customizeUIVIew!
    
    func configureCell(completedGoal: CompletedGoals) {
        
        self.goalDescription.text = completedGoal.goalDescription
        self.goalType.text = completedGoal.goalType
                
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataView.layer.shadowOffset = CGSize(width: 0.0, height: -1.0)
    }
    
    
    
    

}
