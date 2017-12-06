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
    
    //First Color for Color Gradient.
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    //Second Color for Color Gradient.
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    //Shadow Color of a view.
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
            
        }
    }
    
    //Shadow Opacity:
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
            
        }
    }
    
    //Shadow Radius:
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            self.layer.shadowRadius = shadowRadius
        }
    }
    
   /* @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    } */
    
    
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
