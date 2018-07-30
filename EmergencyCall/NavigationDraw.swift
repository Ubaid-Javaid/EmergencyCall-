//
//  NavigationDraw.swift
//  EmergencyCall
//
//  Created by Ubaid on 5/31/18.
//  Copyright © 2018 Ubaid Javaid. All rights reserved.
//

import UIKit
import Firebase

class NavigationDraw: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func History(_ sender: Any) {
        self.performSegue(withIdentifier: "history", sender: self)
    }
    
    
    @IBAction func Profile(_ sender: Any) {
        self.performSegue(withIdentifier: "profile", sender: nil)
    }
    
 
    @IBAction func Logout(_ sender: Any) {
          let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to logout", preferredStyle: .actionSheet)
        let logout1 = UIAlertAction(title: "Logout", style: .destructive) {
            (action) in
            
            do{
                try!Auth.auth().signOut()
              //     self.dismiss(animated: true, completion: nil)
                let Storyboard1 = UIStoryboard(name: "Main", bundle: nil)
                Storyboard1.instantiateInitialViewController()
                let ViewController1:UIViewController = Storyboard1.instantiateViewController(withIdentifier: "MainVC")
                self.present(ViewController1,animated: true,completion: nil)
                UserDefaults.standard.removeObject(forKey: "authVerificationID")
                UserDefaults.standard.synchronize()
                print("Logout")
            }
            catch let LogoutError as NSError{
                print("Logout Error", LogoutError)
        }
    
    }
        let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        alert.addAction(logout1)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }

}
    


















