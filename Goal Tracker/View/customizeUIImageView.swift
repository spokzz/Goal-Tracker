//
//  customizeUIImageView.swift
//  Goal Tracker
//
//  Created by Sakar Pokhrel on 12/9/17.
//  Copyright © 2017 Sakar Pokhrel. All rights reserved.
//

import UIKit

@IBDesignable

class customizeUIImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
