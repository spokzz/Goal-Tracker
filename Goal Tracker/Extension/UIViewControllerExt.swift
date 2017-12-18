//
//  UIViewControllerExt.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/5/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

//VIEW CONTROLLER ANIMATION: (LIKE SHOW SEGUE)
extension UIViewController {
    
    //RIGHT:
    func presentViewController(_ viewController: UIViewController) {
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.3

        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    
    
    //LEFT:
    func dismissViewController() {
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.3
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    
    
}
