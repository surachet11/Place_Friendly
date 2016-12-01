//
//  Config.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//

import Foundation
import UIKit


var categoriesArray = ["ที่จอดรถ","ห้องน้ำ","ลิฟต์", "บันได", "ทางเดินเชื่อมและทางลาด", "ราวจับ","บริการพิเศษ","ห้องพัก"]


var APP_NAME = "Place_Friendly"

let limitForRecentPlaceQuery = 20



let CONTACT_EMAIL_ADDRESS = "surachet11@hotmail.com"

var gray = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
var collViewCells: CGFloat = 3.0


var hudView = UIView()
var indicatorView = UIImageView(frame: CGRect(x:0,y:0,width:80,height:80))

extension UIViewController {
    func showHUD() {
        //hudView.frame = CGPointMake(inview.frame.size.width/2, inview.frame.size.height/2)
        hudView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        hudView.backgroundColor = UIColor.white
        hudView.alpha = 0.9
        
        let imageArr = ["h0", "h1", "h2", "h3", "h4", "h5", "h6", "h7", "h8", "h9"]
        var images : [UIImage] = []
        for i in 0..<imageArr.count {
            images.append(UIImage(named: imageArr[i])!)
        }
        
        indicatorView.animationImages = images
        indicatorView.animationDuration = 0.7
        indicatorView.center = hudView.center
        hudView.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.addSubview(hudView)

    }
    
    func hideHUD() {  hudView.removeFromSuperview()  }
    
    func simpleAlert(_ mess:String) {
        UIAlertView(title: APP_NAME, message: mess, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
}


// PARSE CONFIGURATION ===========================================================
let PARSE_APP_KEY = "fRHjXd9HrHPsFh4jFdkgSRN6orCy6kTZ0r1fryXb"
let PARSE_CLIENT_KEY = "WJfCMd5PE5WIPt0l2uygIzLzwpcKUphe17qce6zI"


//
//// PARSE CONFIGURATION ===========================================================
//let PARSE_APP_KEY = "dXXGoEa3old289ba1UDKY2QSxxUiWryuksJmXgoH"
//let PARSE_CLIENT_KEY = "KSFbsFQ7ILkVH8jsvvT2BsXP5h35vKccyXzLMgAq"
//
//


/* USER CLASS */

var USER_CLASS_NAME = "User"
var USER_ID = "objectId"
var USER_USERNAME = "username"
var USER_FULLNAME = "fullName"
var USER_AGE = "age"
var USER_EMAIL = "email"
var USER_PHOTO = "photo"




/* PLACE CLASS */
var PLACE_CLASS_NAME = "Places"
var PLACE_ID = "objectId"
var PLACE_USER = "User" // User Pointer
var PLACE_FULLNAME = "fullName"
var PLACE_TITLE = "title"
var PLACE_CATEGORY = "category"
var PLACE_ADDRESS = "address" // GeoPoint
var PLACE_ADDRESS_STRING = "addressString"
var PLACE_PRICE = "price"
var PLACE_DESCRIPTION = "description"
var PLACE_DESCRIPTION_LOWERCASE = "descriptionLowercase"
var PLACE_IMAGE1 = "image1" // File
var PLACE_IMAGE2 = "image2" // File
var PLACE_IMAGE3 = "image3" // File
var PLACE_CREATED_AT = "createdAt"
var PLACE_UPDATED_AT = "updatedAt"
var PLACES_START_DATE = "startDate"
var PLACES_KEYWORDS = "keywords"


