//
//  CountryCodeVC.swift
//  EmergencyCall
//
//  Created by Usama Ghalzai on 30/04/2018.
//  Copyright © 2018 Usama Ghalzai. All rights reserved.
//

import UIKit

class CountryCodeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var delegate : popUpDelegates?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCountryCodeCell
        let flag = getFlagBy(countryCode: countryCodes[indexPath.row])
        cell.lblFlag?.text = ("\(flag)\(countryCodes[indexPath.row])")
        cell.lblCountryCode.text = (kCountryDialingCodes[countryCodes[indexPath.row]]!)
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flag = getFlagBy(countryCode: countryCodes[indexPath.row])
        let cC = (kCountryDialingCodes[countryCodes[indexPath.row]]!)
        let flagcC = flag + cC
        print("flagcC",flagcC)
        delegate?.setCountryCode(flag: flag, countryCode: cC)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }
    @IBAction func btnCancel(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    


}
