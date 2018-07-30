//
//  Continuewithmobile.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/15/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import Firebase

class Continuewithmobile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
       // print(arr)
        print( "this is **********\(Auth.auth().currentUser?.uid)")
       
        // Do any additional setup after loading the view.
    }

    
    @IBAction func Continue(_ sender: Any) {
    
        performSegue(withIdentifier: "goto", sender: self)
        
        
    }
    var arr = [String]()
    func loadData() {
        let appdele = UIApplication.shared.delegate as! AppDelegate
        var ref: DatabaseReference!
        ref = Database.database().reference()
  
        ref.child("Users").observe(.childAdded, with: {(DataSnapshot) in
            print(DataSnapshot.key)
            print(DataSnapshot.value!)
           // self.arr.append(DataSnapshot.key)
            
        let todoDic = DataSnapshot.value as! [String:Any]
        let tusers = users(firstname: "", lastname: "", Email: "", Dateofbirth: "", gender: "", phone: "", key: "")
            
            tusers.firstname = todoDic["FirstName"] as! String
            tusers.lastname = todoDic["LastName"] as! String
            tusers.Email = todoDic ["Email"] as! String
            tusers.gender = todoDic ["Gender"] as! String
            tusers.Dateofbirth = todoDic ["DateOfBirth"] as! String
            tusers.phone = todoDic ["Phone"] as! String
   
        appdele.array1.append(tusers)
//            for i in DataSnapshot.key {
//                print(i)
//            }
 
            //print(self.arr)
        }
            )
      
        
        
    }
   
        
        
        
        
        
        
        
        
        
    

  

}
