//
//  Contact.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import MessageUI


class Contact: UIViewController,MFMailComposeViewControllerDelegate,UITextFieldDelegate
    
    
    
{
    
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var messageTxt: UITextView!
    
    @IBOutlet weak var sendOutlet: UIButton!
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var lbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        containerScrollView.contentSize = CGSize(width: containerScrollView.frame.size.width, height: 500)
        sendOutlet.layer.cornerRadius = 5
        
        lbl.frame = CGRect(x:lbl.frame.origin.x, y:20, width:lbl.frame.size.width, height:lbl.frame.size.height)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTxt  { emailTxt.becomeFirstResponder()  }
        if textField == emailTxt  { messageTxt.becomeFirstResponder()  }
        
        return true
    }
    
    
    
    func dismissKeyboard() {
        fullNameTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        messageTxt.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendBtn(_ sender: AnyObject) {
        dismissKeyboard()
        
       let messageStr = "<font size = '1' color= '#222222' style = 'font-family: 'HelveticaNeue'>\(messageTxt.text)</font>"
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject("Message from \(fullNameTxt.text)")
        mailComposer.setMessageBody(messageStr, isHTML: true)
        mailComposer.setToRecipients([CONTACT_EMAIL_ADDRESS])
        
        
        if MFMailComposeViewController.canSendMail() { present(mailComposer, animated: true, completion: nil)
        } else {
            let alert = UIAlertView(title: APP_NAME,
                                    message: "Your device cannot send emails. Please configure an email address into Settings -> Mail, Contacts, Calendars.",
                                    delegate: nil,
                                    cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error:Error?) {
        
        var resultMess = ""
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            resultMess = "Mail cancelled"
        case MFMailComposeResult.saved.rawValue:
            resultMess = "Mail saved"
        case MFMailComposeResult.sent.rawValue:
            resultMess = "Thanks for contacting us!\nWe'll get back to you asap."
        case MFMailComposeResult.failed.rawValue:
            resultMess = "Something went wrong with sending Mail, try again later."
        default:break
        }
        
        // Show email result alert
        simpleAlert(resultMess)
        dismiss(animated:false, completion: nil)
    }
    
    
    
    
    
    @IBAction func tapToDismissKeyboard(sender: UITapGestureRecognizer) {
        
        dismissKeyboard()
    }
    
    
}

