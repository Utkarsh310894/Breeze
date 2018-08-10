//
//  ViewController.swift
//  Breeze
//
//  Created by Utkarsh Sharma on 07/08/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var usernameFeild: UITextField!
    
    @IBOutlet weak var passwordFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (defaults.value(forKey: "isLogin") as? Bool)!{
            let evc =  self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController")
            self.navigationController?.pushViewController(evc, animated: true)
        }
     
        navigationController?.navigationItem.hidesBackButton = true
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        
        if (usernameFeild.text?.isEmpty == true) || (passwordFeild.text?.isEmpty == true)
        {
            displayAlert(userMessage: "Feild can not be empty")
        }
        else{
            if let emailString = usernameFeild.text
            {
                let emailValidate = isEmailValid(email: emailString)
                if emailValidate == false{
                    displayAlert(userMessage: "please enter correct Username")
                }
                else{
                    let testUserName = "utsav.patel.sa@gmail.com"
                    let password = "emp123"
                    
                    if let passwordString = passwordFeild.text
                    {
                        if emailString == testUserName && passwordString == password
                        {
                          loginSucess()
                        }
                        else{
                            displayAlert(userMessage: "Invalid UserName or Password")
                        }
                    }
                }
            }
        }
    }
    
    func displayAlert(userMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isEmailValid(email:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailTest.evaluate(with: email)
    }
    
    func loginSucess(){
            let evc =  self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController")
            self.defaults.set(true, forKey: "isLogin")
            self.navigationController?.pushViewController(evc, animated: true)
        clearTextFeild()
        ApiService.sharedInstance.sendData(url: "http://api.breezworkforce.com/v1/employee/login/") { (a, b) in
            print("done")
        }
    }
    
    func clearTextFeild()
    {
        usernameFeild.text = ""
        passwordFeild.text = ""
    }

}

