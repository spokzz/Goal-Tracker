//
//  HomeCell.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var goalType: UILabel!
    
    func customizeView(goalDescription description: String, goalType type: String) {
        
        goalDescription.text = description
        goalType.text = type
        
    }

}
