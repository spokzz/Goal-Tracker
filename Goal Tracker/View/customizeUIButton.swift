//
//  customizeUIButton.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/3/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

@IBDesignable

class customizeUIButton: UIButton {
    
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    func updateView() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = bounds
       // gradientLayer.locations = [0.7]
       // gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
       // gradientLayer.endPoint = CGPoint(x:1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.masksToBounds = true //It will allow corner Radius to set.
    }

}














