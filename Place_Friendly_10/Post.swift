//
//  Post.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import Parse
import MapKit
import CoreLocation

class Post: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,
    UITableViewDataSource
    //ValidationDelegate
{
    
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var title_txt: UITextField!
        @IBOutlet weak var descrTxt: UITextView!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var buttTAG = Int()
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var deleteOutlet: UIButton!
    
    @IBOutlet weak var categoryOutlet: UIButton!
    

    
    @IBOutlet weak var viewBackgroundSlideOfTableView: UIControl!

    
    @IBOutlet var views: [UIView]!
    
    
    /* Variables */
    
    var arCartrgories : [String] = []


    var placeClass = PFObject(className: PLACE_CLASS_NAME)
    var query = PFQuery(className:PLACE_CLASS_NAME)

    var placeArray = NSMutableArray()
    var locationManager: CLLocationManager!
    
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinView:MKPinAnnotationView!
    var region: MKCoordinateRegion!
    var coordinates: CLLocationCoordinate2D!
    var startDate = NSDate()
    var tempArr = [String]()
    var buttonSelected = UIButton()

    //let validator = Validator()


    @IBOutlet weak var typesCategoryTableView: UITableView!
    
    
    

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
                if PFUser.current() == nil {
                    
                    let alert = UIAlertController(title:APP_NAME,
                        message: "คุณต้อง LogIn หรือ SignUp ก่อนจะโพสต์ครับ",
                        preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "LogIn & SignUp", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                    postBtn.isHidden = true
                    
                    
            
        }
        
        if placeClass.objectId != nil {
            titleLabel.text = "แก้ไขสถานที่ของคุณ"
            postBtn.setTitle("Update", for: UIControlState.normal)
            deleteOutlet.isHidden = false
            showPlaceDetails()
   
        } else {
            deleteOutlet.isHidden = true
        }
        
        
        typesCategoryTableView.frame.origin.x = view.frame.size.height
        
        
        
        deleteOutlet.layer.cornerRadius = 8
        
      
        for aView in views { aView.layer.cornerRadius = 8 }
        
        typesCategoryTableView.layer.cornerRadius = 8
        typesCategoryTableView.layer.borderColor = UIColor.darkGray.cgColor
        typesCategoryTableView.layer.borderWidth = 2
        
        containerScrollView.contentSize = CGSize(width:containerScrollView.frame.size.width, height:deleteOutlet.frame.size.height + deleteOutlet.frame.origin.y + title_txt.frame.origin.y)
        
        
        

        
       
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        title_txt.resignFirstResponder()
        addressTxt.resignFirstResponder()
        descrTxt.resignFirstResponder()
        
    }
    
    
    
    @IBAction func categoryBtn(sender: AnyObject) {
        tempArr.removeAll(keepingCapacity: true)
        tempArr = categoriesArray
        showTableView(buttSel: categoryOutlet)
        
        
    }
   
    
    var selectedCategory:Int? = nil

    
    func hideTableView () {
        typesCategoryTableView.frame.origin.x = view.frame.size.height
        self.viewBackgroundSlideOfTableView.isHidden = true;
        
        //        typesCategoryTableView.center = view.center
        typesCategoryTableView.frame.origin.y += typesCategoryTableView.frame.size.height/2
        typesCategoryTableView.frame.size.height -= typesCategoryTableView.frame.size.height/2
        
        print("self.arCartrgories : \(self.arCartrgories)")
        
        var i = 0
        var str : String = ""
        for (categoryItem) in self.arCartrgories{
            print("categoryItem \(categoryItem)")
            
            if (str == "") {
                str = categoryItem
                
            } else {
                str += ",\(categoryItem)"
            }
            
            i += 1
        }
        categoryOutlet.setTitle(str, for: UIControlState.normal)
    }
    
    func numberOfSections(in
        
        tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        cell.textLabel?.text = "\(tempArr[indexPath.row])"
        
        if indexPath.row == selectedCategory
        {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }

        
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.accessoryType = UITableViewCellAccessoryType.none
        for (categoryItem) in self.arCartrgories {
            
            if categoryItem == tempArr[indexPath.row]
            {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
    }
    
    
 
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        
        
        if cell?.accessoryType == UITableViewCellAccessoryType.none
        {
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark
            
            self.arCartrgories.append(cell!.textLabel!.text!)
        }
        else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.none
            
            var i = 0;
            for (catrgoryItem) in self.arCartrgories {
                if catrgoryItem == cell!.textLabel!.text!{
                    self.arCartrgories .remove(at: i)
                }
                i += 1
            }
        }
        
        
    }

    @IBAction func acViewBackGround(_ sender: AnyObject) {
        self.hideTableView()

    }

    
    func showTableView(buttSel:UIButton) {
        typesCategoryTableView.reloadData()
        
        self.viewBackgroundSlideOfTableView.isHidden = false;
        
        typesCategoryTableView.center = view.center
        typesCategoryTableView.frame.origin.y -= typesCategoryTableView.frame.size.height
        typesCategoryTableView.frame.size.height += typesCategoryTableView.frame.size.height
    }
    

    
    
    
    @IBAction func pictuerBtn(_ sender: AnyObject) {
        let button = sender as! UIButton
        buttTAG = button.tag
        
        let alert = UIAlertView(title: APP_NAME,
            message: "Select source",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Camera", "Photo Library")
        alert.show()

        
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if alertView.buttonTitle(at: buttonIndex) == "Take a picture" {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
            
        }else if alertView.buttonTitle(at:buttonIndex) == "Photo Library"  {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
            
            
        }else if alertView.buttonTitle(at: buttonIndex) == "Delete Place" {
            var placeClass = PFObject(className: PLACE_CLASS_NAME)
            placeClass = placeArray[0] as! PFObject
            placeClass.deleteInBackground {(success, error) -> Void in
                if error == nil {
                    self.dismiss(animated:true, completion: nil)
                } else {
                 self.simpleAlert("\(error!.localizedDescription)")
                } }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
        switch buttTAG {
        case 1: img1.image = image; break
        case 2: img2.image = image; break
        case 3: img3.image = image; break
        default:break
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    @IBAction func deletePlace(_ sender: AnyObject) {
        let alert = UIAlertView(title: APP_NAME,
            message: "Are you sure you want to delete this Place?",
            delegate: self,
            cancelButtonTitle: "No",
            otherButtonTitles: "Delete Place")
        alert.show()
    }
    
    
    @IBAction func setCurrentLocation(_ sender: AnyObject) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        if locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)){
            locationManager.requestAlwaysAuthorization()
            
        }
        locationManager.startUpdatingLocation()
    }
    
    
    
    @IBAction func postAdButt(_ sender: AnyObject) {
        showHUD()
        print("POST OBJ (At save/Update): \(placeClass)")
        

        if title_txt.text == "" || categoryOutlet == nil || descrTxt.text == ""
            || addressTxt.text == "" || coordinates == nil
            || img1.image == nil {
            simpleAlert("You must fill all the fields and add at least an image!")
            hideHUD()
            
        } else {
            
            
            // POST A NEW AD -----------------------------------------------------------------------
            if PFUser.current() != nil  &&   placeClass.objectId == nil {
                postPlace("Your Place has been successfully posted!")
                
                // UPDATE SELECTED AD ----------------------------------------------------------------------
            } else if PFUser.current() != nil  &&  placeClass.objectId != nil {
                postPlace("Your Place has been successfully updated!")
            }
            
        }
    }
 
    
    func postPlace(_ withMess: String) {
        // Save PFUser as Pointer (if needed)
        placeClass[PLACE_USER] = PFUser.current()
        
        // Save other data
        placeClass[PLACE_TITLE] = title_txt.text
        placeClass[PLACE_CATEGORY] = categoryOutlet.titleLabel!.text!
        placeClass[PLACE_DESCRIPTION] = descrTxt.text
        placeClass[PLACE_DESCRIPTION_LOWERCASE] = descrTxt.text!.lowercased()
        placeClass[PLACE_ADDRESS_STRING] = addressTxt.text!.lowercased()
        placeClass[PLACES_KEYWORDS] = "\(title_txt.text!.lowercased()) \(addressTxt.text)"
        placeClass[PLACES_START_DATE] = startDate

        
        // Add keywords
        let k1 = title_txt.text!.lowercased().components(separatedBy: " ") as [String]
        let k2 = descrTxt.text!.lowercased().components(separatedBy: " ") as [String]
        let k3 = addressTxt.text!.lowercased().components(separatedBy: " ") as [String]
        let keywords = k1 + k2 + k3
        placeClass[PLACES_KEYWORDS] = keywords
        
        
        if coordinates != nil {
            let geopoint = PFGeoPoint(latitude: coordinates.latitude, longitude: coordinates.longitude)
            placeClass[PLACE_ADDRESS] = geopoint
            
        }
        
        if (img1.image != nil) {
            let imageData = UIImageJPEGRepresentation(img1.image!, 0.5)
            let imageFile = PFFile(name: "img1.jpg", data:imageData!)
            placeClass[PLACE_IMAGE1] = imageFile
        }
        
        if (img2.image != nil) {
            let imageData = UIImageJPEGRepresentation(img2.image!, 0.5)
            let imageFile = PFFile(name: "img2.jpg", data:imageData!)
            placeClass[PLACE_IMAGE2] = imageFile
        }
        
        if (self.img3.image != nil) {
            let imageData = UIImageJPEGRepresentation(self.img3.image!, 0.5)
            let imageFile = PFFile(name: "img3.jpg", data:imageData!)
            placeClass[PLACE_IMAGE3] = imageFile
        }
        
        
        // Saving block
        placeClass.saveInBackground { (success, error) -> Void in
            if error == nil {
                self.simpleAlert("Successfully post")
                self.dismiss(animated: true, completion: nil)
                self.hideHUD()
                
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
            }}
    }

    
   
   
    
    //VALIDATE POST
//  
//    func validateInput()-> Bool {
//        var title = title_txt
//        var descr = descrTxt.text
//        var address    = addressTxt.text
//        
//        
//        var valid:Bool = true
//        
//        if  title == "" {
//            
//            validator.registerField(title_txt, errorLabel: title_error , rules: [RequiredRule(), MinLengthRule()])
//            
//            
//            valid = false
//        }
//        
//        
//        if  descr  == ""  {
//            
//           validator.registerField(title_txt, errorLabel: descrError , rules: [RequiredRule(), MinLengthRule()])
//            
//            valid = false
//            
//        }
//        
//        if  address == "" {
//            
//            validator.registerField(addressTxt, errorLabel: address_error , rules: [RequiredRule(), MinLengthRule()])
//            
//            valid = false
//        }
//        
//        validator.validate(self)
//        
//        return valid
//    }
//    
//    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: %@",error)
        
        self.simpleAlert("Failed to Get Your Location")

        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        
        let location = locations.last
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location!, completionHandler: { (placemarks, error) -> Void in
            
            let placeArray :[CLPlacemark] = placemarks!
            var placemark:CLPlacemark
            placemark = placeArray[0]
            
            let street = placemark.addressDictionary?["Name"] as? String ?? ""
            
            let city = placemark.addressDictionary?["CITY"] as? String ?? ""
            
            let zip = placemark.addressDictionary?["ZIP"] as? String ?? ""
            
            let state = placemark.addressDictionary?["State"] as? String ?? ""
            
            let country = placemark.addressDictionary?["Country"] as? String ?? ""
            
            self.addressTxt.text = "\(street), \(city), \(state), \(country)"
            
            if self.addressTxt!.text! != "" { self.addPinOnMap(address: self.addressTxt.text!) }
            
        })
    }
    
    func addPinOnMap(address:String) {
        
        if mapView.annotations.count != 0 {
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = address
        localSearch = MKLocalSearch(request: localSearchRequest)
        
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                self.simpleAlert("Place not found, or GPS not available")
                
            }else {
                
                self.pointAnnotation = MKPointAnnotation()
                self.pointAnnotation.title = self.title_txt.text
                self.pointAnnotation.subtitle = self.addressTxt.text
                self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
                
                self.coordinates = self.pointAnnotation.coordinate
                self.pinView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
                self.mapView.centerCoordinate = self.pointAnnotation.coordinate
                self.mapView.addAnnotation(self.pinView.annotation!)
                
                self.region = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, 10000, 10000)
                self.mapView.setRegion(self.region, animated: true)
                self.mapView.regionThatFits(self.region)
                self.mapView.reloadInputViews()
                
            }
        }
        
        
    }
    
    
    @IBAction func cancelBtn(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
//    func queryYourPlace() {
//        
//        placeArray.removeAllObjects()
//        
//        var query = PFQuery(className: PLACE_CLASS_NAME)
//        query.whereKey(PLACE_ID, equalTo: postID)
//        query.findObjectsInBackground { (objects, error) -> Void in
//            if error == nil {
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        
//                        self.placeArray.addObject(object)
//                        
//                    }
//                }
//                self.showPlaceDetails()
//            } else {
//                var alert = UIAlertView(title: APP_NAME,
//                    message: "Something went wrong, try again later or check your internet connection",
//                    delegate: self,
//                    cancelButtonTitle: "OK" )
//                alert.show()
//            }
//        }
//    }
//    
//    
    
    
//    
//    func queryYourPlace() {
//        
//        
//        let query = PFQuery(className: PLACE_CLASS_NAME)
//        query.whereKey(PLACE_ID, equalTo: postID)
//        query.findObjectsInBackground { (objects, error) -> Void in
//            if error == nil {
//                if let objects = objects as [PFObject]! {
//                    for object in objects {
//                        
//                        self.placeArray.add(object)
//                        
//                    }
//                }
//                self.showPlaceDetails()
//            } else {
//                var alert = UIAlertView(title: APP_NAME,
//                                        message: "Something went wrong, try again later or check your internet connection",
//                                        delegate: self,
//                                        cancelButtonTitle: "OK" )
//                alert.show()
//            }
//        }
//    }
//    
//    
    func showPlaceDetails() {
        
        
        
        if placeClass[PLACE_TITLE] != nil {
            title_txt.text = "\(placeClass[PLACE_TITLE]!)"
            
        } else {
            title_txt.text = ""
        }
        
        if placeClass[PLACE_DESCRIPTION] != nil {
            descrTxt.text = "\(placeClass[PLACE_DESCRIPTION]!)"
        } else {
            descrTxt.text = ""
        }
        
        
        if placeClass[PLACE_ADDRESS_STRING] != nil {
            addressTxt.text = "\(placeClass[PLACE_ADDRESS_STRING]!)"
        } else {
            addressTxt.text = ""
        }
        
        
        
        if placeClass[PLACE_CATEGORY] != nil {
            categoryOutlet.setTitle("\( placeClass[PLACE_CATEGORY]!)", for: UIControlState.normal)
            
        }
            
        else { categoryOutlet.setTitle("Select Type", for: UIControlState.normal) }
        
        addPinOnMap(address: addressTxt.text!)
        
        let imageFile1 = placeClass[PLACE_IMAGE1] as? PFFile
        imageFile1?.getDataInBackground { (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.img1.image = UIImage(data: imageData)
                    
                }
                
            }
        }
        
        let imageFile2 = placeClass [PLACE_IMAGE2] as? PFFile
        imageFile2?.getDataInBackground{ (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.img2.image = UIImage(data:imageData)
                } } }
        
        
        let imageFile3 = placeClass [PLACE_IMAGE3] as? PFFile
        imageFile3?.getDataInBackground { (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.img3.image = UIImage(data:imageData)
                } } }
    }
    

    
    
    
    
    
    
    
    
    
    
//    func showPlaceDetails() {
//        var placeClass = PFObject(className: PLACE_CLASS_NAME)
//        placeClass = placeArray[0] as! PFObject
//        
//        if placeClass[PLACE_TITLE] != nil {
//            title_txt.text = "\(placeClass[PLACE_TITLE]!)"
//            
//        } else {
//            title_txt.text = ""
//        }
//        
//        if placeClass[PLACE_DESCRIPTION] != nil {
//            descrTxt.text = "\(placeClass[PLACE_DESCRIPTION]!)"
//        } else {
//             descrTxt.text = ""
//        }
//        
//        
//        if placeClass[PLACE_ADDRESS_STRING] != nil {
//            addressTxt.text = "\(placeClass[PLACE_ADDRESS_STRING]!)"
//        } else {
//            addressTxt.text = ""
//        }
//        
//       
//        
//        if placeClass[PLACE_CATEGORY] != nil {
//            let str : String = placeClass[PLACE_CATEGORY] as! String
//            self.arCartrgories = str.components(separatedBy: ",")
//            categoryOutlet.setTitle("\(str)", for: UIControlState.normal)
//        }
//            
//        else { categoryOutlet.setTitle("Select Type", for: UIControlState.normal) }
//
//        addPinOnMap(address: addressTxt.text!)
//        
//        let imageFile1 = placeClass[PLACE_IMAGE1] as? PFFile
//        imageFile1?.getDataInBackground (block: { (imageData, error) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    self.img1.image = UIImage(data: imageData)
//                    
//                }
//                
//            }
//        })
//        
//        let imageFile2 = placeClass [PLACE_IMAGE2] as? PFFile
//        imageFile2?.getDataInBackground (block: { (imageData, error) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    self.img2.image = UIImage(data:imageData)
//                } } })
//        
//        
//        let imageFile3 = placeClass [PLACE_IMAGE3] as? PFFile
//        imageFile3?.getDataInBackground(block: { (imageData, error) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    self.img3.image = UIImage(data:imageData)
//                } } })
//    }
    
    
 
    
    
   
    
    
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return categoriesArray.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return categoriesArray[row]
//    }
//    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        categoryTxt.text = "\(categoriesArray[row])"
//    }
//    
//    
//    func showCatPickerView() {
//        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
//            self.categoryContainer.frame.origin.y = self.view.frame.size.height - self.categoryContainer.frame.size.height
//            }, completion: { (finished: Bool) in  });
//    }
//    func hideCatPickerView() {
//        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
//            self.categoryContainer.frame.origin.y = self.view.frame.size.height
//            }, completion: { (finished: Bool) in  });
//    }
    
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        if textField == categoryTxt {
//            showCatPickerView()
//            title_Txt.resignFirstResponder()
//            categoryTxt.resignFirstResponder()
//        }
//        
//        return true
//    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        if textField == categoryTxt {
//            showCatPickerView()
//            title_Txt.resignFirstResponder()
//            categoryTxt.resignFirstResponder()
//        }
//        
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Get address for the Map
        if textField == addressTxt {
            if addressTxt.text != "" {  addPinOnMap(address: addressTxt.text!)  }
        }
    }
    
  
    
}















