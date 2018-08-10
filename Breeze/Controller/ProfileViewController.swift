//
//  DetailViewController.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 09/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
    
    let url = "http://api.breezworkforce.com/v1/employee/getProfile"
    @IBOutlet weak var lblModifiedDate: UILabel!
    @IBOutlet weak var lblCreatedDate: UILabel!
    @IBOutlet weak var lblHourlyPay: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblfirstName: UILabel!
    @IBOutlet weak var lblEmployeeId: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblCompanyId: UILabel!
    
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLogin")
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func showClicked(_ sender: UIBarButtonItem) {
     let EmployeeDataTableViewController =  self.storyboard!.instantiateViewController(withIdentifier: "EmployeeDataTableViewController")
        navigationController?.pushViewController(EmployeeDataTableViewController, animated: true)
    }
    var employeeData : [Employee] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let alert = UIAlertController(title: "Success", message: "Login Successfull", preferredStyle: .alert)
            self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                     alert.dismiss(animated: true, completion: nil)
                }
        }
        
        navigationController?.navigationItem.hidesBackButton = true
        ApiService.sharedInstance.getEmpData(url: url) { (data) in
            DispatchQueue.main.async {
                self.employeeData = data
                self.navigationItem.title = "Profile"
                self.lblId.text = "\(self.employeeData[0].id!)"
                self.lblEmail.text = self.employeeData[0].email
                self.lblAddress.text = self.employeeData[0].address
                self.lblfirstName.text = self.employeeData[0].firstName
                self.lblLastName.text = self.employeeData[0].lastName
                self.lblCompanyId.text = "\(self.employeeData[0].companyId!)"
                self.lblHourlyPay.text = self.employeeData[0].hourlyPay
                self.lblCreatedDate.text = self.employeeData[0].created
                self.lblModifiedDate.text = self.employeeData[0].modified
                self.lblDesignation.text = self.employeeData[0].designation
                self.lblPhoneNumber.text = self.employeeData[0].phoneNumber
                self.lblEmployeeId.text = self.employeeData[0].employeeId
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
