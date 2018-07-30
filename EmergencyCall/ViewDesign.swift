//
//  ViewDesign.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/21/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit

@IBDesignable class ViewDesign: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
    }
   


}
