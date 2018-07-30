//
//  verifyNumber.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/14/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class verifyNumber: UIViewController,UITextFieldDelegate {
    var arr = [String]()
      var time = Timer()
    var seconds = 60
      var window: UIWindow?
     var ref : DatabaseReference!
      let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var Resndcode: UIButton!
    
    
    @IBOutlet weak var phonelabel: UILabel!
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var textField3: UITextField!
    
    @IBOutlet weak var textField4: UITextField!
    
    
    @IBOutlet weak var textField5: UITextField!
    
    @IBOutlet weak var textField6: UITextField!
    
    @IBOutlet weak var resendCode: UILabel!
    
    @IBOutlet weak var requestCall: UILabel!
    
    
    override func viewDidLoad() {
        
        
      
        loadData()
        Resndcode.isEnabled = false
    
        
           time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        
        super.viewDidLoad()
        self.textField1.becomeFirstResponder()
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
        textField6.delegate = self
        
        
        //
        
        textField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
       textField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
       textField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
       textField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         textField5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         textField6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        
        self.phonelabel.text = appdelegate.number
        

        


    }
    
    func loadData() {
        //  let appdele = UIApplication.shared.delegate as! AppDelegate
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Users").observe(.childAdded, with: {(DataSnapshot) in
          //  print(DataSnapshot.key)
            // print(DataSnapshot.value!)
            self.arr.append(DataSnapshot.key)
              print(self.arr)
            
        }
            
            
            )   }
    
    
    
    @objc func UpdateTimer() {
    
        
      

        seconds -= 1
        resendCode.text = "00:\(seconds)"
        requestCall.text = "00:\(seconds)"
        if seconds == 0 {
            time.invalidate()
            Resndcode.isEnabled = true
        }
    }
    
    
    @IBAction func ResendCode(_ sender: Any) {
      UserAuthentication(number1: self.phonelabel.text!)
        // time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        Resndcode.isEnabled = false
        
//        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
//Resndcode.tintColor = .blue
        
        
        
        
    }
    //
    func UserAuthentication(number1 : String) {
        
       // self.phonelabel.text = number1
        //Firebase Authentication
        // kPhoneNumber = number
        PhoneAuthProvider.provider().verifyPhoneNumber(number1, uiDelegate : nil) { (verificationID, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            UserDefaults.standard.synchronize()
        }
    }
    //
//    func switchStoryboard() {
//        let storyboard = UIStoryboard(name:"Main",bundle:nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "mapView") as! MapViewController1
//        self.present(controller,animated: true,completion: nil)
//        
//    }
    
    //
    func userVerification(){
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential:PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode:"\(textField1.text!)\(textField2.text!)\(textField3.text!)\(textField4.text!)\(textField5.text!)\(textField6.text!)")
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if (self.arr.contains((Auth.auth().currentUser?.uid)!) == true)

{
    
    
                if (error == nil) {
                    
                  //  let controller = self.storyboard?.instantiateViewController(withIdentifier: "mapView") as! MapViewController1
                    //self.present(controller, animated: true, completion: nil)
                    print("userID Be like \(Auth.auth().currentUser!.uid)")
                    print ("Old Users")
//
                    self.performSegue(withIdentifier: "maps", sender: self)
//                    print("New User")
//                    print("userID Be like \(Auth.auth().currentUser!.uid)")
//                    print("Successfull")
                }
                else{
                    let alert = UIAlertController(title: "Error ", message: "The SMS verification code is Invalid", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true,completion: nil)
                    self.textField1.text = nil
                    self.textField2.text = nil
                    self.textField3.text = nil
                    self.textField4.text = nil
                    self.textField5.text = nil
                    self.textField6.text = nil
                    
                    
                    print("error : \(String(describing: error?.localizedDescription))")
                }
            }
            
else {
                if (error == nil)
                                {
                                    self.performSegue(withIdentifier: "Goto", sender: self)
                                                    print("New User")
                                                        print("userID Be like \(Auth.auth().currentUser!.uid)")
                                                      print("Successfull")
                
                                }
                    
                else{
                                        let alert = UIAlertController(title: "Error ", message: "The SMS verification code is Invalid", preferredStyle: UIAlertControllerStyle.alert)
                    
                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                                        self.present(alert, animated: true,completion: nil)
                                        self.textField1.text = nil
                                        self.textField2.text = nil
                                        self.textField3.text = nil
                                        self.textField4.text = nil
                                        self.textField5.text = nil
                                        self.textField6.text = nil
                    
                    
                                        print("error : \(String(describing: error?.localizedDescription))")
            }
            
//            else {
//                if (error == nil)
//                {
//                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "mapView") as! MapViewController1
//                    self.present(controller, animated: true, completion: nil)
//                    print("userID Be like \(Auth.auth().currentUser!.uid)")
//                    
//                    
//                    
//                    //
//                    
//                }
//                else{
//                    let alert = UIAlertController(title: "Error ", message: "The SMS verification code is Invalid", preferredStyle: UIAlertControllerStyle.alert)
//                    
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                    
//                    self.present(alert, animated: true,completion: nil)
//                    self.textField1.text = nil
//                    self.textField2.text = nil
//                    self.textField3.text = nil
//                    self.textField4.text = nil
//                    self.textField5.text = nil
//                    self.textField6.text = nil
//                    
//                    
//                    print("error : \(String(describing: error?.localizedDescription))")
//                }
//            }

           

            
        }
    }
    
    }


    @objc func textFieldDidChange (textField:UITextField)
    {
        let text = textField.text
        
        

        if text?.count == 1{
            switch textField {
            case textField1:
              //  textField1.borderRect(forBounds: <#T##CGRect#>) = .red
               
                
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
               textField5.becomeFirstResponder()
            case textField5:
                textField6.becomeFirstResponder()
            case textField6:
                userVerification()
                
                textField6.resignFirstResponder()
                
            default:
                break
            }
        }
    }
    
   
  
    @IBAction func BackButton(_ sender: Any) {
      //  performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        
    }
    
   
    @IBAction func EditButton(_ sender: Any) {
        
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        
        
    }
    
    
    
    
    
}
