//
//  customizeUIVIew.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/2/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

@IBDesignable

class customizeUIVIew: UIView {
    
    //COLOR GRADIENT (FIRST COLOR)
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    //COLOR GRADIENT (SECOND COLOR)
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    //SHADOW COLOR
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
            
        }
    }
    
    //SHADOW OPACITY:
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
            
        }
    }
    
    //SHADOW RADIUS:
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    //CORNER RADIUS
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //BORDER WIDTH
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    //BORDER COLOR
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    } 
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }

    
    func updateView() {
        
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.masksToBounds = true
        
    }
    

}
