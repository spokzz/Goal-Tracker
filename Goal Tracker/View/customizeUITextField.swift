//
//  customizeUITextField.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

@IBDesignable

class customizeUITextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let p = placeholder {
           attributedPlaceholder = NSAttributedString(string: p , attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        }
    }
    
    var edgeInsets = UIEdgeInsetsMake(0, 16, 0, 0)

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    
    

}
