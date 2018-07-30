//
//  Mapview.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/24/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit

class Mapview: UIViewController {
    var value = 0.0
var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
         timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)

        // Do any additional setup after loading the view.
    }
    
    @objc func timeToMoveOn() {
        //self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "GO", sender: self)
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
