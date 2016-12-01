//
//  Home.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/2/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//

import UIKit
import Parse
import AudioToolbox

class Home: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate,
UITextFieldDelegate,
UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var eventsCollView: UICollectionView!
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var searchPlace: UITextField!
    
    
    
    var placesArray = [PFObject]()
    var propObj = PFObject(className: PLACE_CLASS_NAME)
    //var userPointer = PFObject(className: USER_CLASS_NAME)
    var userArray = NSMutableArray()
    var cellSize = CGSize()
    var searchViewIsVisible = false
    var singleID = String()

    
       

    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            cellSize = CGSize(width:view.frame.size.width-30,height: 250)
        } else {
            cellSize = CGSize(width:350,height:250)
        }
        
        searchView.frame.origin.y = -searchView.frame.size.height
        searchView.layer.cornerRadius = 10
        searchViewIsVisible = false
        searchTxt.resignFirstResponder()
        searchPlace.resignFirstResponder()
        
        searchTxt.attributedPlaceholder = NSAttributedString (string: "Type an place name(or leave it blank)", attributes: [NSForegroundColorAttributeName:UIColor.gray] )
        searchPlace.attributedPlaceholder = NSAttributedString (string: "Type a city/town name (or leave it blank)", attributes: [NSForegroundColorAttributeName:UIColor.gray])
        
        
        queryLatestEvents()

    }
    
    func queryLatestEvents() {
        
       // placesArray.removeAll()
        showHUD()
        
        let query = PFQuery(className: PLACE_CLASS_NAME)
        query.order(byDescending: PLACE_CREATED_AT)
        query.limit = limitForRecentPlaceQuery
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                
                self.placesArray = objects!
                self.eventsCollView.reloadData()
                self.hideHUD()
                
                
                
//                
//                DispatchQueue.main.asynchronously() {
//
//                
//                self.eventsCollView.reloadData()
//                hudView.removeFromSuperview()
//                }
                
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
                

            }
        }
                
        self.title = "หน้าแรก"

    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placesArray.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        
        var placeClass = PFObject(className: PLACE_CLASS_NAME)
        placeClass = placesArray[(indexPath as NSIndexPath).row]
        
        
        let imageFile = placeClass[PLACE_IMAGE1] as? PFFile
        imageFile?.getDataInBackground { (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    cell.eventImage.image = UIImage(data:imageData)
        
                    
                } } }
        
        let  dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let dayStr = dayFormatter.string(from:placeClass[PLACES_START_DATE] as! Date)
        cell.dayLabel.text = dayStr
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        let monthStr = monthFormatter.string(from:placeClass[PLACES_START_DATE] as! Date)
        cell.monthLabel.text = monthStr
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let yearStr = yearFormatter.string(from:placeClass[PLACES_START_DATE] as! Date)
        cell.yearLabel.text = yearStr
        
        cell.titleLbl.text = "\(placeClass[PLACE_TITLE]!)".uppercased()
        cell.locationLbl.text = "\(placeClass[PLACE_ADDRESS_STRING]!)".uppercased()
        
        let str : String = (placeClass[PLACE_CATEGORY] as? String)!
        cell.showCategory.text = str.replacingOccurrences(of: ",", with: " ,")
        
       
   
        

       var userPointer = placeClass[PLACE_USER] as! PFUser
       
        
        do { userPointer = try userPointer.fetchIfNeeded() } catch {  print("Error") }
        
        if userPointer[PLACE_FULLNAME] != nil
        
        {
            
            cell.usernameLb.text = userPointer.username!
       
        
        }
        
        
   

        
        
//     
//        let userPointer1 = propObj[PLACE_USER] as! PFUser
//        userPointer1.fetchIfNeededInBackground { (user, error) in
//            if error == nil {
//                cell.usernameLb.text = userPointer1.username!
//            }else {
//                print("user: \(cell.usernameLb.text)")
//                self.simpleAlert("\(error!.localizedDescription)")}
//            
//        }
//        
//        
//        
//        let userPointer = eventObj[PLACE_USER] as! PFUser
//        userPointer.fetchIfNeededInBackground { (user, error) in
//            if error == nil {
//                
//                
//                self.postLbl.text = userPointer.username!
//                
//                let str : String = (eventObj[PLACE_CATEGORY] as? String)!
//                self.showCategory.text = str.replacingOccurrences(of: ",", with: " ,")
//                
//            }  else { self.simpleAlert("\(error!.localizedDescription)")}
//            
//        }
//        
//    }
        
        
    return cell
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

    
    // MARK: - TAP A CELL TO OPEN PLACE DETAILS
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placesClass = placesArray[indexPath.row]
        hideSearchView()

        
        let pVC = storyboard?.instantiateViewController(withIdentifier: "ShowSinglePlace") as! ShowSinglePlace
        pVC.singleID = placesClass.objectId!
        navigationController?.pushViewController(pVC, animated: true)
        
      
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func searchBtn(_ sender: AnyObject) {
        
        searchViewIsVisible = !searchViewIsVisible
        
        if searchViewIsVisible {
            showSearchView()
        } else {
            hideSearchView()
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideSearchView()
        
        placesArray.removeAll()
        let keywordsArray = searchTxt.text!.components(separatedBy:" ") as [String]
        //println("\(keywordsArray)")
        
        let query = PFQuery(className: PLACE_CLASS_NAME)
        if searchTxt.text != "" {
            query.whereKey(PLACES_KEYWORDS, contains: "\(keywordsArray[0])".lowercased())
            
        }
        if searchPlace.text != "" {
            query.whereKey(PLACES_KEYWORDS, contains: "\(searchPlace.text)".lowercased())
        }
        
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                self.placesArray = objects!
              
                
                if self.placesArray.count > 0 {
        
                    self.eventsCollView.reloadData()
                    self.title = "สถานที่ได้ค้นเจอ"
                    self.hideHUD()
                    
                    
                }else {
                    self.simpleAlert( "ไม่เจอนะครับ. รบกวนพิมพ์คำใหม่นะครับ")
                    self.hideHUD()
                    
                   // dispatch_async(dispatch_get_main_queue()) {
                        self.queryLatestEvents()

                   // }
                    
            }
            
            
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
                    
              //      hudView.removeFromSuperview()

            }
        }
        
        return true
    }
   
    func showSearchView() {
        searchTxt.becomeFirstResponder()
        searchTxt.text = "";  searchPlace.text = ""
        
        UIView.animate(withDuration:0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.searchView.frame.origin.y = 32
            }, completion: { (finished: Bool) in })
    }
    func hideSearchView() {
        searchTxt.resignFirstResponder(); searchPlace.resignFirstResponder()
        searchViewIsVisible = false
        
        UIView.animate(withDuration:0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.searchView.frame.origin.y = -self.searchView.frame.size.height
            }, completion: { (finished: Bool) in })
    }
    


    
    @IBAction func refreshBtn(_ sender: AnyObject) {
        queryLatestEvents()
        searchTxt.resignFirstResponder();
        searchPlace.becomeFirstResponder()
        hideSearchView()
        searchViewIsVisible = false
        
        self.title = "สถานที่ล่าสุด"
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
