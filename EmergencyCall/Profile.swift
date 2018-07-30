//
//  Profile.swift
//  EmergencyCall
//
//  Created by Ubaid on 6/26/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit

class Profile: UIViewController {

    var tempuser = users(firstname: "", lastname: "", Email: "", Dateofbirth: "", gender: "", phone: "")
    
    @IBOutlet weak var firstname: UITextField!
    
    
    
    @IBOutlet weak var lastname: UITextField!
    
    
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var dateofbirth: UITextField!
    
    
    @IBOutlet var gender: [UIButton]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appdele = UIApplication.shared.delegate as! AppDelegate
        self.tempuser = appdele.currentuser
        
        self.firstname.text = tempuser.firstname
        self.lastname.text = tempuser.lastname
        self.email.text = tempuser.Email
        self.dateofbirth.text = tempuser.Dateofbirth
    }

    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

   

}
