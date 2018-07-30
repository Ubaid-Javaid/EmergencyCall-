//
//  DesignView1.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/21/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit

@IBDesignable class DesignView1: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }


}
