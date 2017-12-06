//
//  UIViewControllerExt.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/5/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //It will present view controller like Segue (Show)
    func presentViewController(_ viewController: UIViewController) {
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.3
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    
    //It will present root View Controller.
    func rootVC(viewController: UIViewController) {
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 0.3
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
    }
    
    //It will dismiss view controller like Segue (Show)
    func dismissViewController() {
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.duration = 0.3
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    
    
}
