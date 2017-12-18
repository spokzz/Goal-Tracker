//
//  SideViewCell.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

//MENU TABLE VIEW CELL:

class SideViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func customizeView(buttonInfo: SideViewModel) {
        
        iconImageView.image = UIImage(named: buttonInfo.icon)
        title.text = buttonInfo.title
        
       
    }

}
