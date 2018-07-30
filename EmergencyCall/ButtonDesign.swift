//
//  ButtonDesign.swift
//  EmergencyCall
//
//  Created by Ubaid Javaid on 01/05/2018.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit

 @IBDesignable class ButtonDesign: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat  = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
}
