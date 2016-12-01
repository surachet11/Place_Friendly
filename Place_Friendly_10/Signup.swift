//
//  Signup.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import Parse

//extension String {
//    var length: Int { return count(self)         }
//}

class Signup: UIViewController,UITextFieldDelegate

{
    
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
//    @IBOutlet weak var userNameError: UILabel!
//    @IBOutlet weak var passwordError: UILabel!
//    @IBOutlet weak var emailError: UILabel!
    
    
//    let validator = Validator()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        


        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupBtn(_ sender: AnyObject) {
        
        if usernameTxt.text == "" || passwordTxt.text == "" || emailTxt.text == "" {
            simpleAlert("You must fill all the fields to Sign Up!")
            
        } else {
            showHUD()
            let userForSignUp = PFUser()
            userForSignUp.username = usernameTxt.text
            userForSignUp.password = passwordTxt.text
            userForSignUp.email = emailTxt.text
            
            userForSignUp.signUpInBackground { (succeeded, error) -> Void in
                if error == nil { // Successful Signup
                    self.dismiss(animated: true, completion: nil)
                    self.hideHUD()
                    
                    // error
                } else {
                    self.simpleAlert("\(error!.localizedDescription)")
                    self.hideHUD()
                }}
            
        }
        
    
        
        
        
//        if self.validateInput() == true {
//            
//        showHUD()
//            
//        var userForSignUp = PFUser()
//        userForSignUp.username = usernameTxt.text
//        userForSignUp.password = passwordTxt.text
//        userForSignUp.email = emailTxt.text
//        
//        
//        
//        
//        userForSignUp.signUpInBackground { (succeeded, error) -> Void in
//        hudView.removeFromSuperview()
//            
//      
//            if  error!.code == 202 {
//                self.userNameError.isHidden = false
//                self.userNameError.text = "Username นี้ได้ถูกใช้แล้ว"
//                self.usernameTxt.layer.borderColor = UIColor.red.cgColor
//            }
//                
//             else if error!.code == 203 {
//                self.emailError.isHidden = false
//                 self.emailTxt.layer.borderColor = UIColor.red.cgColor
//                self.emailError.text = "Email นี้ได้ถูกใช้แล้ว"
//                
//            
//            }
//            else  {
//                    if error == nil {
//                            self.dismiss(animated: true, completion: nil)
//                               }
//            
//            else {
//                var alert = UIAlertView(title: APP_NAME ,
//                    message: "เกิดปัญหาขัดข้อง โปรดลงทะเบียนใหม่อีกครั้ง",
//                    delegate: nil,
//                    cancelButtonTitle: "OK" )
//                alert.show()
//                
//                hudView.removeFromSuperview()
//            }
//        }
//    }
//        
//    }
}
    

    
//    func validateInput()-> Bool {
//        var username = usernameTxt.text
//        var password = passwordTxt.text
//        var email    = emailTxt.text
//        
//        
//        var valid:Bool = true
//        
//        if  username == "" {
//            
//            validator.registerField(usernameTxt, errorLabel: userNameError , rules: [RequiredUsername(), MinLengthRule()])
//            
//            
//            valid = false
//        }
//        
//        
//        if  password == ""  {
//            
//            validator.registerField(passwordTxt, errorLabel: passwordError , rules: [RequiredPassword()])
//            
//            valid = false
//            
//        }
//        
//        if  email == "" {
//            
//             validator.registerField(emailTxt, errorLabel: emailError , rules: [RequiredEmail_(),EmailRule()])
//            
//            valid = false
//        }
//
//          validator.validate(self)
//               
//        return valid
//    }
    
    

    
    
    @IBAction func taptoDismissKeyboard(_ sender: UITapGestureRecognizer) {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        
    }
    
    
    
    @IBAction func dissMissBtn(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxt {
            passwordTxt.becomeFirstResponder()
            
        }
        if textField == passwordTxt {
            emailTxt.becomeFirstResponder()
        }
        if textField == emailTxt {
            emailTxt.resignFirstResponder()
        }
        return true
    }
    
    
   
    
    
}
