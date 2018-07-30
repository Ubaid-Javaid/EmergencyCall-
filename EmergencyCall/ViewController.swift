//
//  ViewController.swift
//  EmergencyCall
//
//  Created by Ubaid Javaid on 30/04/2018.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class users {
    var firstname: String!
    var lastname : String!
    var Email : String!
    var Dateofbirth : String!
    var gender : String!
    var phone : String!
    var key : String!
    init(firstname:String,lastname:String,Email:String,Dateofbirth:String,gender:String,phone:String,key:String = " " ) {
        self.firstname = firstname
        self.lastname = lastname
        self.Email = Email
        self.Dateofbirth = Dateofbirth
        self.gender = gender
        self.phone = phone
        self.key = key
    }
    func toAnyObject() -> [String:Any]
    {
        return ["FirstName":firstname,"LastName":lastname,"Email":Email,"Gender":gender,"DateOfBirth":Dateofbirth,"Phone":phone]
    }
}

class ViewController: UIViewController,UITextFieldDelegate {
   
    
    
    var tempuser = users(firstname: "", lastname: "", Email: "", Dateofbirth: "", gender: "", phone: "")
    @IBOutlet var btncheck: [UIButton]!
    
    var num = " "
    
       var array = ["1","2","3","4","5","6","7","8","9","0"]
   //var abc = [users]()
var anstext = ""

    
    var pickerView = UIPickerView()
    
    
    @IBOutlet weak var Firstname: UITextField!
    
    @IBOutlet weak var Lastname: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    
    @IBOutlet weak var DateOfBirth: UITextField!
    
    
    
    @IBOutlet weak var Signup: ButtonDesign!
    
//    var gender = ["MALE","FEMALE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.Firstname.becomeFirstResponder()
        
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        self.num = appdelegate.number
        
       // self.Firstname.delegate = self
       // self.Lastname.delegate = self
        //self.Email.delegate = self
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView.backgroundColor = .gray
        
      
        
        
        //GenderField?.delegate = self
        //GenderField?.inputView = pickerView
      
     
       
        
        // Date OF Birth
        
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width,height:40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
       // let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Ariel", size: 18)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = ""
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        DateOfBirth.inputAccessoryView = toolBar
      
        
       
        
        
    
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        
     DateOfBirth.resignFirstResponder()
//        GenderField.resignFirstResponder()
         self.view.frame.origin.y = 0
        
        
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.medium
        
        dateformatter.timeStyle = DateFormatter.Style.none
        
        DateOfBirth.text = dateformatter.string(from: NSDate() as Date)
        
        DateOfBirth.resignFirstResponder()
    }
    
    
    
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.maximumDate = Date()
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
         //self.view.frame.origin.y = -50
        
        
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        DateOfBirth.text = dateFormatter.string(from: sender.date)
        
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    
    


    
    
 
    
//
//    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardshow(notification:)),
//            name: .UIKeyboardWillShow,object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardhide(notification:)),
//                                                   name: .UIKeyboardWillHide,object: nil)
//    }
//
//    @objc func keyboardshow (notification:Notification) {
//        if self.Email.isEditing {
//            self.view.frame.origin.y = -getHeight (notification : notification)
//        }
//    }
//
//    @objc func keyboardhide(notification:Notification) {
//    self.view.frame.origin.y = 0
//    }
//
//    func getHeight (notification:Notification)->CGFloat {
//        let info = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
//        return info.cgRectValue.height
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        let Eamil1 = self.Email.text!
        var status = 0
        for i in array{
            if (self.Firstname.text?.contains(i)) == true  {
                
                let alert = UIAlertController(title: "Error", message: "Invalid Firstname", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            status = 1
            }
        }
        for j in array{
            if (self.Lastname.text?.contains(j) == true) {
                
                let alert = UIAlertController(title: "Error", message: "Invalid Lastname", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                status = 1
            }
        }
        if (Firstname.text == "")   {
            
            print("Error")
            let alert = UIAlertController(title: "Error ", message: "Reqired First Name", preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

            self.present(alert, animated: true,completion: nil)
        }
        
       else if (Lastname.text == "")   {
            let alert = UIAlertController(title: "Error", message: "Reqired Last Name", preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

            self.present(alert, animated: true,completion: nil)
        }
            
            
        else if (Email.text == "")   {
            let alert = UIAlertController(title: "Error", message: "Reqired Email ", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true,completion: nil)
        }
            
        else if (DateOfBirth.text == "")   {
            let alert = UIAlertController(title: "Error", message: "Reqired Date Of Birth ", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true,completion: nil)
        }
            
        else if (anstext == "")   {
            let alert = UIAlertController(title: "Error", message: "Select your gender", preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

            self.present(alert, animated: true,completion: nil)
        }
            
            
        
        else if(status == 0) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
//            Auth.auth().createUser(withEmail: Eamil1, password: "123456"){
//                (user, error) in
//                if user != nil
             //{
                    var ref : DatabaseReference!
                    ref = Database.database().reference()
                    let Data = ref.child("Users").child(Auth.auth().currentUser!.uid)
            self.tempuser = users(firstname: self.Firstname.text!, lastname: self.Lastname.text!, Email: self.Email.text!, Dateofbirth: self.DateOfBirth.text!, gender:self.anstext, phone: num)
                    
                  Data.setValue(self.tempuser.toAnyObject())
                    print("Success")
           // appDelegate.array1.append(user1)
          
                  // self.GenderField.inputView = self.PickerView
                    
                 
//                    self.GenderField.text = ""
                    self.performSegue(withIdentifier: "gotomap", sender: self)
                    self.Firstname.text = nil
                    self.Lastname.text = nil
                    self.Email.text = nil
                    self.DateOfBirth.text = nil
                    
                
                }
//                else
//                {
//                    if let myError = error?.localizedDescription
//                    {
//                        let alert = UIAlertController(title: "Error", message: myError, preferredStyle: UIAlertControllerStyle.alert)
//
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//
//                        self.present(alert, animated: true,completion: nil)
//                    }
//
//                    else{
//                        print("Error")
//                    }
//
//                }
            }
            
                let appdel = UIApplication.shared.delegate as! AppDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotomap" {
            appdel.currentuser = self.tempuser
        }
    }
            
            
          
       // }
        
        
        
    //}
    
    
    func uncheckAllButtons(){
        for btn in btncheck{
            btn.isSelected = false
        }
    }
  
    @IBAction func btncheck(_ sender: UIButton) {
        self.uncheckAllButtons()
        
        sender.isSelected  = true
        
        if sender.tag == 0 {
            
            self.anstext = "Male"
            print("Male")
            
            
        }
        if sender.tag == 1 {
            
            self.anstext = "Female"
            print("Female")
            
            
        }
    }
    
}

