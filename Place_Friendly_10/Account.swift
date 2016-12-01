//
//  Account.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//


import UIKit
import Parse




class Account: UIViewController,UITextFieldDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate
{
    
    
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var yourImage: UIImageView!
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var fullNametxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var saveProfileBtn: UIButton!
    @IBOutlet weak var myPostsOutlet: UIButton!
    
    @IBOutlet weak var logout_Outlet: UIBarButtonItem!
    @IBOutlet weak var postPlace: UIBarButtonItem!
    
    @IBOutlet weak var tuchPhotoLb: UILabel!
    @IBOutlet weak var buttonPhoto: UIButton!
    
    @IBOutlet weak var logIn_SignupBtn: UIButton!
    
    var didLoadUserDetail : Bool = false
    
    
    var eventObj = PFObject(className: PLACE_CLASS_NAME)
    //var placesArray = [PFObject]()
    //var userArray = [PFObject]()
    var userArray = NSMutableArray()


    
    override func viewWillAppear(_ animated: Bool) {
        //println("reloadUser:\(reloadUser)")
        
        if PFUser.current() == nil {
            
            //dispatch_get_main_queue().asynchronously()}
    
            
            
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = nil
            self.usernameLb.isHidden = true
            self.tuchPhotoLb.text =  "โปรดทำการ LogIn หรือ SignUp"
            self.tuchPhotoLb.textColor =  UIColor.red
            self.tuchPhotoLb.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
            self.tuchPhotoLb.font = UIFont.boldSystemFont(ofSize: 14.0)
            self.buttonPhoto.isHidden = true
            self.fullNametxt.isUserInteractionEnabled = false
            self.emailTxt.isUserInteractionEnabled = false
            self.myPostsOutlet.isHidden = true
            self.saveProfileBtn.isHidden = true
            self.logIn_SignupBtn.isHidden = false
            self.logIn_SignupBtn.layer.cornerRadius = 8
            
                        
            }
            

        //{
            
         else {
            
            if didLoadUserDetail == false {
                loadUserDetails()
                didLoadUserDetail = true
            }
            
            self.tuchPhotoLb.text =  "แตะที่รูปเพื่อเปลี่ยนภาพใหม่"
            self.tuchPhotoLb.font = UIFont(name: "HelveticaNeue-UltraLight", size: CGFloat(11))
            self.tuchPhotoLb.textColor =  UIColor.black
            self.tuchPhotoLb.isHidden = false
            self.usernameLb.isHidden = false
            self.buttonPhoto.isHidden = false
            self.logIn_SignupBtn.isHidden = true
            self.fullNametxt.isUserInteractionEnabled = true
            self.emailTxt.isUserInteractionEnabled = true
            self.myPostsOutlet.isHidden = false
            self.saveProfileBtn.isHidden = false
            

            let LogOutButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(Account.leftBarbutton))
            navigationItem.leftBarButtonItem = LogOutButton
            LogOutButton.tintColor = UIColor.white

            let AddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(Account.rightBarbutton)) //Use a selector
            navigationItem.rightBarButtonItem = AddButton
            AddButton.tintColor = UIColor.white
            
            
            }
        
    }
    
    func leftBarbutton() {
        PFUser.logOut()
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier:"Login") as! Login
        present(loginVC,animated:true,completion:nil)

    }
    
    func rightBarbutton() {
        
        let postVC = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! Post
        present(postVC, animated: true, completion: nil)
//        
//        let pVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowSinglePlace") as! ShowSinglePlace
//        navigationController?.pushViewController(pVC, animated: true)
       
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    


        yourImage.layer.cornerRadius = yourImage.bounds.size.width/2
        
        
        saveProfileBtn.layer.cornerRadius = 8
        myPostsOutlet.layer.cornerRadius = 8
//        
//        
//       containerScrollView.contentSize = CGSize(width:containerScrollView.frame.size.width, height:600)
//        

        
    }
    

//    
//    func loadUserDetails() {
//        userArray.removeAllObjects()
//        
//        var query = PFUser.query()
//        query?.whereKey(USER_USERNAME, equalTo: PFUser.currentUser()!.username!)
//        query?.findObjectsInBackgroundWithBlock { (objects, error)-> Void in
//            if error == nil {
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        self.userArray.addObject(object)
//                    } }
//                
//                self.showUserDetails()
//                
//            } else {
//                var alert = UIAlertView(title: APP_NAME,
//                    message: "Something went wrong, try again later or check your internet connection",
//                    delegate: self,
//                    cancelButtonTitle: "OK" )
//                alert.show()
//            }
//        }
//        
//    }
    
    ////////////////////////
    
    func loadUserDetails() {
        
        userArray.removeAllObjects()

        let query = PFUser.query()
        query?.whereKey(USER_USERNAME, equalTo: PFUser.current()!.username!)
        query?.findObjectsInBackground { (objects, error)-> Void in
            if error == nil {
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        self.userArray.add(object)
                    } }
                
                self.getUserDetails()
                
            } else {
                let alert = UIAlertView(title: APP_NAME,
                                        message: "Something went wrong, try again later or check your internet connection",
                                        delegate: self,
                                        cancelButtonTitle: "OK" )
                alert.show()
            }
        }
        
    }
    
    
    func getUserDetails() {
        var userClass = PFObject(className: USER_CLASS_NAME)
        userClass = userArray[0] as! PFObject
        
        usernameLb.text = "\(userClass[USER_USERNAME]!)"
        emailTxt.text = "\(userClass[USER_EMAIL]!)"
        
        if userClass[USER_FULLNAME] != nil {
            fullNametxt.text = "\(userClass[USER_FULLNAME]!)"
        } else { fullNametxt.text = "" }
        
        if userClass[USER_EMAIL] != nil {
            emailTxt.text = "\(userClass[USER_EMAIL]!)"
        } else { emailTxt.text = "" }

        
        let imageFile = userClass[USER_PHOTO] as? PFFile
        imageFile?.getDataInBackground (block: { (imageData, error) -> Void in
           
            
            if error == nil {
                if let imageData = imageData {
                    self.yourImage.image = UIImage(data:imageData)
                }} })
        
    }

    
    func showUserDetails() {
        
        let currUser = PFUser.current()!
        
        usernameLb.text = "\(currUser[USER_USERNAME]!)"
        emailTxt.text = "\(currUser[USER_EMAIL]!)"
        
        if currUser[USER_FULLNAME] != nil {
            fullNametxt.text = "\(currUser[USER_FULLNAME]!)"
        } else { fullNametxt.text = "" }
        
        
        if currUser[USER_EMAIL] != nil {
            emailTxt.text = "\(currUser[USER_EMAIL]!)"
        } else { emailTxt.text = "" }
        
        // Get Avatar image
        
        
        if yourImage.image == nil {
            let imageFile = currUser[USER_PHOTO] as? PFFile
            imageFile?.getDataInBackground (block: { (imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.yourImage.image = UIImage(data:imageData)
                    
                    }}})
            
        }
}


    func dismissKeyboard() {
        
        fullNametxt.resignFirstResponder()
        emailTxt.resignFirstResponder()

        
    }
    
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNametxt
        { emailTxt.becomeFirstResponder()}
        
        
        return true
    }
    

    
    @IBAction func ChangeImgBtn(_ sender: AnyObject) {
        let alert = UIAlertView(title: APP_NAME,
        message: "Add a Photo",
        delegate: self,
        cancelButtonTitle: "Cancel",
        otherButtonTitles: "Take a picture",
        "Choose from Library")
        alert.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.buttonTitle(at: buttonIndex) == "Take a picture" {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
                
            }
        } else if alertView.buttonTitle(at: buttonIndex) == "Choose from Library" {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            yourImage.image = image
            
            let currUser = PFUser.current()!
            let imageData = UIImagePNGRepresentation(image)
            let imagePFFile = PFFile(data: imageData!)
//            currUser.setObject(imagePFFile, forKey: "USER_PHOTO")
            currUser[USER_PHOTO] = imagePFFile
            currUser.saveInBackground()
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtn(_ sender: AnyObject) {
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! Login
        navigationController?.pushViewController(loginVC, animated: true)

    }
    
    
    @IBAction func postPlace(_ sender: AnyObject) {
        
        let postVC = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! Post
        present(postVC, animated: true, completion: nil)
    }

        
    
    @IBAction func saveProfile(_ sender: AnyObject) {
        
        showHUD()
        dismissKeyboard()
       
    

        let currentUser = PFUser.current()!
        currentUser.setObject(fullNametxt.text!, forKey: USER_FULLNAME)
        currentUser.setObject(emailTxt.text!, forKey: USER_EMAIL)

        
        
        if yourImage.image != nil {
            let imageData = UIImageJPEGRepresentation(yourImage.image!,0.5)
            let imageFile = PFFile(name:"avatar.jpg", data:imageData!)
            currentUser.setObject(imageFile!, forKey: USER_PHOTO)
        }
        
        currentUser.saveInBackground { (success, error) -> Void in
           
            
            if error == nil {
                self.simpleAlert("Your Profile has been updated!")
                self.hideHUD()
                
            }else {
      
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
            }
        }
    }
    
    

    
  
    
    
    @IBAction func myPostsBtn(sender: AnyObject) {
        let myPlaceVC = storyboard?.instantiateViewController(withIdentifier:"MyTableViewController") as! MyTableViewController
        
        navigationController?.pushViewController(myPlaceVC, animated: true)
        
        //self.presentViewController(myPlaceVC, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func logIn_SignupBtn(sender: AnyObject) {
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier:"Login") as! Login
        self.present(loginVC,animated:true,completion:nil)
        
        
    }
    
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        
        fullNametxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
       
    }
    
    
    
}








