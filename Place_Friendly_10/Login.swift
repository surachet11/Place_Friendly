//
//  Login.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import Parse
//import ParseUI


var reloadUser = Bool()

class Login: UIViewController,
    UITextFieldDelegate,UIAlertViewDelegate
{
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var signupOutlet: UIButton!
    
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErorLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginOutlet.layer.cornerRadius = 5
        signupOutlet.layer.cornerRadius = 5
        
        
        containerScrollView.contentSize = CGSize(width: containerScrollView.frame.size.width, height: 550)
        
        self.navigationController?.isNavigationBarHidden = true
        
    
    }
    
    
    
    
    @IBAction func loginButt(sender: AnyObject) {
        
      
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        
        showHUD()
        
        
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!) { (user, error) -> Void in
            if user != nil { // Login successfull
                self.hideHUD()
                self.dismiss(animated: true, completion: nil)
                
                
            } else {
                let alert = UIAlertView(title: APP_NAME , message: "Username หรือ Password ไม่ถูกต้อง", delegate: self, cancelButtonTitle: "ลองอีกครั้ง", otherButtonTitles: "Sign Up")
                alert.show()
                
                self.hideHUD()
              }
            }
        }
    
  
    @IBAction func taptoDismissKeyboard(sender: UITapGestureRecognizer) {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
    

    @IBAction func forgotPWD(_ sender: AnyObject) {
        
        let alert = UIAlertView(title: APP_NAME,
            message: "Type your email address you used to register.",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Reset Password")
        alert.alertViewStyle = UIAlertViewStyle.plainTextInput
        alert.show()
        
    }
    
         func showNotifAlert() {
            simpleAlert("You will receive an email shortly with a link to reset your password")
        }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.buttonTitle(at: buttonIndex) == "Sign Up" {
            signupBtn(self)
        }
        
        if alertView.buttonTitle(at: buttonIndex) == "Reset Password" {
            if alertView.textField(at: 0)?.text != "" {
                PFUser.requestPasswordResetForEmail(inBackground: "\(alertView.textField(at: 0)!.text!)")
                showNotifAlert()
            } else {
                simpleAlert("Field cannot be empty!")
            }
        }
    
    }


    
    @IBAction func signupBtn(_ sender: AnyObject) {
        
        let SignupVC = self.storyboard?.instantiateViewController(withIdentifier:"Signup") as! Signup
        self.present(SignupVC,animated:true,completion:nil)
        
    }


    
    
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxt{
            passwordTxt.becomeFirstResponder()
        }
        if textField == passwordTxt {
            passwordTxt.resignFirstResponder()
        }
        return true  
    }
    
    
    
}
