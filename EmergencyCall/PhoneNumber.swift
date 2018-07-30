//
//  PhoneNumber.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/12/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import FirebaseAuth
import CountryPickerView

class PhoneNumber: UIViewController {
 let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20 ))
    
    @IBOutlet weak var PhoneTextField: UITextField!
    var num:Int!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var id  = [String]()
        for i in appdelegate.array1{
            id.append(i.key)
        }
        print(id)

        PhoneTextField.leftView = cp
        PhoneTextField.leftViewMode = .always
     
    }
    
    let cpv = CountryPickerView.self
  
    
    
    func UserAuthentication(number : String) {
        
        //self.PhoneTextField.text = number
        //Firebase Authentication
       // kPhoneNumber = number
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate : nil) { (verificationID, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UserDefaults.standard.synchronize()
        }
    }
  

    @IBAction func Countinue(_ sender: Any) {
          print(self.PhoneTextField.text?.count)
  
        
      
      
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        if (PhoneTextField.text == "")   {
            
            print("Error")
            let alert = UIAlertController(title: "Error ", message: "Required Phone Number", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true,completion: nil)
        }
        else if (self.PhoneTextField.text?.count)! > 10 {
            let alert = UIAlertController(title: "Number is Too Big ", message: "Please correct your number ", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
        }
            else if (self.PhoneTextField.text?.count)! < 10 {
                        let alert = UIAlertController(title: "Number is Too Short ", message: "Please correct your number ", preferredStyle: .alert)
                        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                        alert.addAction(okay)
                        self.present(alert, animated: true, completion: nil)
            
                    }
            

        else {
            
           // performSegue(withIdentifier: "next", sender: nil)
            let alert = UIAlertController(title: "Is your mobile number correct?", message:"\(self.cp.selectedCountry.phoneCode)\(self.PhoneTextField.text!)" , preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
                appdelegate.number = "\(self.cp.selectedCountry.phoneCode)\(self.PhoneTextField.text!)"
                
                self.UserAuthentication(number:"\(self.cp.selectedCountry.phoneCode)\(self.PhoneTextField.text!)")
                
                
                
                
                
                
              self.performSegue(withIdentifier: "next", sender: nil)
                

            }))

            alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: nil))




            self.present(alert, animated: true,completion: nil)
//
        }
        
//
        
        
        
    
   
}
    @IBAction func UnWindEdit(_ segue:UIStoryboardSegue){
        
    }
}
