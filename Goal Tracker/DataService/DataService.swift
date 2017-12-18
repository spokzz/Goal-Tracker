//
//  DataService.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import Foundation

//PROVIDES DATA TO REAR VIEW (TABLE VIEW CELL)
class DataService {
    
   static let instance = DataService()
    
    private var buttonLabel: [SideViewModel] = [
        
        SideViewModel(icon: "home", title: "Home"),
        SideViewModel(icon: "history", title: "History"),
        SideViewModel(icon: "help", title: "Help"),
        SideViewModel(icon: "profile", title: "My Profile")
        
    ]
    
    func getSideViewButtonLabel() -> [SideViewModel] {
    
      return buttonLabel
        
    }
    
}
