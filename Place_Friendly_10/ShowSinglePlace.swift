//
//  ShowSinglePlace.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import MapKit
import Parse
import Social
import MessageUI

class ShowSinglePlace: UIViewController,UIAlertViewDelegate,UIScrollViewDelegate,
    UITextFieldDelegate,MKMapViewDelegate
    
{
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var loadingTitle: UILabel!
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var btnFB: UIButton!

    
    @IBOutlet weak var lblPrefixAddress: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var lblPrefixShowCategory: UILabel!
    @IBOutlet weak var showCategory: UILabel!
    
    @IBOutlet weak var lblPrefixPost: UILabel!
    @IBOutlet weak var postLbl: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    

    
    @IBOutlet weak var postOutlet: UIBarButtonItem!
    
    
    var eventObj = PFObject(className: PLACE_CLASS_NAME)
    var userPointer = PFObject(className: USER_CLASS_NAME)
    
    var singleArray = NSMutableArray()
    var singleID = String()
    var placeObj = PFObject(className: PLACE_CLASS_NAME)
    var PlacesArray = [PFObject]()
    var socialController = SLComposeViewController()



    
    
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinView:MKPinAnnotationView!
    var region: MKCoordinateRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerScrollView.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_containerScrollView = NSLayoutConstraint(item: containerScrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let lcLeft_containerScrollView = NSLayoutConstraint(item: containerScrollView, attribute: .leftMargin, relatedBy: .equal, toItem: self.view, attribute: .leftMargin, multiplier: 1.0, constant: 0.0)
        let lcRight_containerScrollView = NSLayoutConstraint(item: containerScrollView, attribute: .rightMargin, relatedBy: .equal, toItem: self.view, attribute: .rightMargin, multiplier: 1.0, constant: 0.0)
        let lcBottom_containerScrollView = NSLayoutConstraint(item: containerScrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([lcTop_containerScrollView,
            lcLeft_containerScrollView,
            lcRight_containerScrollView,
            lcBottom_containerScrollView])
        
        self.view.layoutIfNeeded()
        
//        containerScrollView.contentSize = CGSize(width: containerScrollView.frame.size.width, height: 750)
        
        imagesScrollView.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_imagesScrollView  = NSLayoutConstraint(item: imagesScrollView, attribute: .top, relatedBy: .equal, toItem: loadingTitle, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcCenterX_imageScollView = NSLayoutConstraint(item: imagesScrollView, attribute: .centerX, relatedBy: .equal, toItem: containerScrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let lcWidth_imageScollView = NSLayoutConstraint(item: imagesScrollView, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_imagesScrollView = NSLayoutConstraint(item: imagesScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerScrollView.frame.size.width * 0.56)
        
        containerScrollView.addConstraints([lcTop_imagesScrollView,
                                            lcCenterX_imageScollView,
                                            lcWidth_imageScollView,
                                         lcHeight_imagesScrollView
            ])
        
        imagesScrollView.contentSize = CGSize(width: imagesScrollView.frame.size.width * 3, height: imagesScrollView.frame.size.height)
        
        
        image1.translatesAutoresizingMaskIntoConstraints = false
        let lcLeft_image1  = NSLayoutConstraint(item: image1, attribute: .left, relatedBy: .equal, toItem: imagesScrollView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let lcCenterY_image1 = NSLayoutConstraint(item: image1, attribute: .centerY, relatedBy: .equal, toItem: imagesScrollView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let lcWidth_image1 = NSLayoutConstraint(item: image1, attribute: .width, relatedBy: .equal, toItem: imagesScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_image1 = NSLayoutConstraint(item: image1, attribute: .height, relatedBy: .equal, toItem: imagesScrollView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        imagesScrollView.addConstraints([lcLeft_image1,
            lcCenterY_image1,
            lcWidth_image1,
            lcHeight_image1
            ])
        
        image1.contentMode = .scaleAspectFill
//        image1.frame.origin.x = 0
        
        image2.contentMode = .scaleAspectFill
//        image2.frame.origin.x = imagesScrollView.frame.size.width
        
        image2.translatesAutoresizingMaskIntoConstraints = false
        let lcLeft_image2  = NSLayoutConstraint(item: image2, attribute: .left, relatedBy: .equal, toItem: image1, attribute: .right, multiplier: 1.0, constant: 0.0)
        let lcCenterY_image2 = NSLayoutConstraint(item: image2, attribute: .centerY, relatedBy: .equal, toItem: imagesScrollView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let lcWidth_image2 = NSLayoutConstraint(item: image2, attribute: .width, relatedBy: .equal, toItem: imagesScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_image2 = NSLayoutConstraint(item: image2, attribute: .height, relatedBy: .equal, toItem: imagesScrollView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        imagesScrollView.addConstraints([lcLeft_image2,
                                         lcCenterY_image2,
                                         lcWidth_image2,
                                         lcHeight_image2
            ])
        
        image3.contentMode = .scaleAspectFill
//        image3.frame.origin.x = imagesScrollView.frame.size.width*2
        
        image3.translatesAutoresizingMaskIntoConstraints = false
        let lcLeft_image3  = NSLayoutConstraint(item: image3, attribute: .left, relatedBy: .equal, toItem: image2, attribute: .right, multiplier: 1.0, constant: 0.0)
        let lcCenterY_image3 = NSLayoutConstraint(item: image3, attribute: .centerY, relatedBy: .equal, toItem: imagesScrollView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let lcWidth_image3 = NSLayoutConstraint(item: image3, attribute: .width, relatedBy: .equal, toItem: imagesScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_image3 = NSLayoutConstraint(item: image3, attribute: .height, relatedBy: .equal, toItem: imagesScrollView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        imagesScrollView.addConstraints([lcLeft_image3,
                                         lcCenterY_image3,
                                         lcWidth_image3,
                                         lcHeight_image3
            ])
        
        self.commentText.isEditable = false

        imagesScrollView.layoutIfNeeded()
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_pageControl  = NSLayoutConstraint(item: pageControl, attribute: .top, relatedBy: .equal, toItem: imagesScrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcCenterX_pageControl = NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: containerScrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let lcWidth_pageControl = NSLayoutConstraint(item: pageControl, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_pageControl = NSLayoutConstraint(item: pageControl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_pageControl,
                                            lcCenterX_pageControl,
                                            lcWidth_pageControl,
                                            lcHeight_pageControl
            ])
        
        pageControl.layoutIfNeeded()

        lblComment.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_lblComment  = NSLayoutConstraint(item: lblComment, attribute: .top, relatedBy: .equal, toItem: pageControl, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcCenterX_lblComment = NSLayoutConstraint(item: lblComment, attribute: .centerX, relatedBy: .equal, toItem: containerScrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let lcWidth_lblComment = NSLayoutConstraint(item: lblComment, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_lblComment = NSLayoutConstraint(item: lblComment, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_lblComment,
                                    lcCenterX_lblComment,
                                    lcWidth_lblComment,
                                    lcHeight_lblComment
            ])
        
        lblComment.layoutIfNeeded()
        containerScrollView.layoutIfNeeded()
        
        commentText.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_commentText  = NSLayoutConstraint(item: commentText, attribute: .top, relatedBy: .equal, toItem: lblComment, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_commentText = NSLayoutConstraint(item: commentText, attribute: .left, relatedBy: .equal, toItem: containerScrollView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let lcWidth_commentText = NSLayoutConstraint(item: commentText, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.8, constant: 0.0)
        let lcHeight_commentText = NSLayoutConstraint(item: commentText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_commentText,
                                            lcLeft_commentText,
                                            lcWidth_commentText,
                                            lcHeight_commentText
            ])
        
        commentText.layoutIfNeeded()
        
        btnFB.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_btnFB  = NSLayoutConstraint(item: btnFB, attribute: .top, relatedBy: .equal, toItem: lblComment, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcRight_btnFB = NSLayoutConstraint(item: btnFB, attribute: .left, relatedBy: .equal, toItem: commentText, attribute: .right, multiplier: 1.0, constant: 3.0)
        let lcWidth_btnFB = NSLayoutConstraint(item: btnFB, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.2, constant: -3.0)
        let lcHeight_btnFB = NSLayoutConstraint(item: btnFB, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_btnFB,
                                            lcRight_btnFB,
                                            lcWidth_btnFB,
                                            lcHeight_btnFB
            ])
        
        btnFB.imageView?.contentMode = .scaleAspectFit
        
        btnFB.layoutIfNeeded()
        
        lblPrefixAddress.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_lblPrefixAddress  = NSLayoutConstraint(item: lblPrefixAddress, attribute: .top, relatedBy: .equal, toItem: commentText, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_lblPrefixAddress = NSLayoutConstraint(item: lblPrefixAddress, attribute: .left, relatedBy: .equal, toItem: containerScrollView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let lcWidth_lblPrefixAddress = NSLayoutConstraint(item: lblPrefixAddress, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.2, constant: 0.0)
        let lcHeight_lblPrefixAddress = NSLayoutConstraint(item: lblPrefixAddress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_lblPrefixAddress,
                                            lcLeft_lblPrefixAddress,
                                            lcWidth_lblPrefixAddress,
                                            lcHeight_lblPrefixAddress
            ])
        
        lblPrefixAddress.layoutIfNeeded()
        
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_addressLbl  = NSLayoutConstraint(item: addressLbl, attribute: .top, relatedBy: .equal, toItem: commentText, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_addressLbl = NSLayoutConstraint(item: addressLbl, attribute: .left, relatedBy: .equal, toItem: lblPrefixAddress, attribute: .right, multiplier: 1.0, constant: 3.0)
        let lcWidth_addressLbl = NSLayoutConstraint(item: addressLbl, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.8, constant: -3.0)
        let lcHeight_addressLbl = NSLayoutConstraint(item: addressLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_addressLbl,
                                            lcLeft_addressLbl,
                                            lcWidth_addressLbl,
                                            lcHeight_addressLbl
            ])
        
        addressLbl.layoutIfNeeded()

        
        lblPrefixShowCategory.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_lblPrefixShowCategory  = NSLayoutConstraint(item: lblPrefixShowCategory, attribute: .top, relatedBy: .equal, toItem: addressLbl, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_lblPrefixShowCategory = NSLayoutConstraint(item: lblPrefixShowCategory, attribute: .left, relatedBy: .equal, toItem: containerScrollView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let lcWidth_lblPrefixShowCategory = NSLayoutConstraint(item: lblPrefixShowCategory, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.2, constant: 0.0)
        let lcHeight_lblPrefixShowCategory = NSLayoutConstraint(item: lblPrefixShowCategory, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_lblPrefixShowCategory,
                                            lcLeft_lblPrefixShowCategory,
                                            lcWidth_lblPrefixShowCategory,
                                            lcHeight_lblPrefixShowCategory
            ])
        
        lblPrefixShowCategory.layoutIfNeeded()
        
        showCategory.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_showCategory  = NSLayoutConstraint(item: showCategory, attribute: .top, relatedBy: .equal, toItem: addressLbl, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_showCategory = NSLayoutConstraint(item: showCategory, attribute: .left, relatedBy: .equal, toItem: lblPrefixShowCategory, attribute: .right, multiplier: 1.0, constant: 3.0)
        let lcWidth_showCategory = NSLayoutConstraint(item: showCategory, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.8, constant: -3.0)
        let lcHeight_showCategory = NSLayoutConstraint(item: showCategory, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_showCategory,
                                            lcLeft_showCategory,
                                            lcWidth_showCategory,
                                            lcHeight_showCategory
            ])
        
        showCategory.layoutIfNeeded()
        
        lblPrefixPost.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_lblPrefixPost  = NSLayoutConstraint(item: lblPrefixPost, attribute: .top, relatedBy: .equal, toItem: showCategory, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_lblPrefixPost = NSLayoutConstraint(item: lblPrefixPost, attribute: .left, relatedBy: .equal, toItem: containerScrollView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let lcWidth_lblPrefixPost = NSLayoutConstraint(item: lblPrefixPost, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.2, constant: 0.0)
        let lcHeight_lblPrefixPost = NSLayoutConstraint(item: lblPrefixPost, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_lblPrefixPost,
                                            lcLeft_lblPrefixPost,
                                            lcWidth_lblPrefixPost,
                                            lcHeight_lblPrefixPost
            ])
        
        lblPrefixPost.layoutIfNeeded()
        
        postLbl.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_postLbl  = NSLayoutConstraint(item: postLbl, attribute: .top, relatedBy: .equal, toItem: showCategory, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcLeft_postLbl = NSLayoutConstraint(item: postLbl, attribute: .left, relatedBy: .equal, toItem: lblPrefixPost, attribute: .right, multiplier: 1.0, constant: 3.0)
        let lcWidth_postLbl = NSLayoutConstraint(item: postLbl, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 0.8, constant: -3.0)
        let lcHeight_postLbl = NSLayoutConstraint(item: postLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        
        containerScrollView.addConstraints([lcTop_postLbl,
                                            lcLeft_postLbl,
                                            lcWidth_postLbl,
                                            lcHeight_postLbl
            ])
        
        postLbl.layoutIfNeeded()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let lcTop_mapView  = NSLayoutConstraint(item: mapView, attribute: .top, relatedBy: .equal, toItem: postLbl, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let lcCenterX_mapView = NSLayoutConstraint(item: mapView, attribute: .centerX, relatedBy: .equal, toItem: containerScrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let lcWidth_mapView = NSLayoutConstraint(item: mapView, attribute: .width, relatedBy: .equal, toItem: containerScrollView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let lcHeight_mapView = NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: containerScrollView.frame.size.width * 0.56)
        
        containerScrollView.addConstraints([lcTop_mapView,
                                            lcCenterX_mapView,
                                            lcWidth_mapView,
                                            lcHeight_mapView
            ])

        containerScrollView.layoutIfNeeded()

        self.view.layoutIfNeeded()
        
        containerScrollView.contentSize = CGSize(width: containerScrollView.frame.size.width, height:  lcHeight_mapView.constant+mapView.frame.origin.y)
    }
    
    
    @IBAction func acBackButton(sender: AnyObject) {
        
        self.navigationController!.popViewController(animated: true)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if PFUser.current() != nil {
            
            singleArray.removeAllObjects()
            querySingle()

            
        }else {
            
            self.navigationItem.setRightBarButton(nil, animated: true)
            singleArray.removeAllObjects()
            querySingle()
        }
        
    }
    
    func querySingle() {
        showHUD()
        print("SingleQuery AD ID: \(singleID)")
        
        let query = PFQuery(className: PLACE_CLASS_NAME)
        query.whereKey(PLACE_ID, equalTo: singleID)
        //query.whereKey(PLACE_ID, equalTo: singleID)
        query.includeKey(PLACE_USER)
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                
                if let objects = objects as [PFObject]? {
                    for object in objects {
                        self.singleArray.add(object)
                    }
                 }
                self.showDetails()
                self.hideHUD()

                
            } else {
                self.simpleAlert("\(error!.localizedDescription)")
                self.hideHUD()
                
            }
        }
    }
    
    func showDetails() {
        var eventObj = PFObject(className: PLACE_CLASS_NAME)
        eventObj = singleArray[0] as! PFObject
        
        loadingTitle.text = "\(eventObj[PLACE_TITLE]!)"
        self.title = "\(eventObj[PLACE_TITLE]!)"
        
        var i: NSInteger = 0;
        let imageFile1 = eventObj[PLACE_IMAGE1] as? PFFile
        imageFile1?.getDataInBackground (block: { (imageData , error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.image1.image = UIImage(data: imageData)
                    
                    i+=1;
                    self.pageControl.numberOfPages = i
                }
            }
        })
        
        let imageFile2 = eventObj[PLACE_IMAGE2] as? PFFile
        imageFile2?.getDataInBackground (block: { (imageData , error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.image2.image = UIImage(data:imageData)
                    
                    i+=1;
                    self.pageControl.numberOfPages = i
                } } })
        
        
        let imageFile3 = eventObj[PLACE_IMAGE3] as? PFFile
        imageFile3?.getDataInBackground (block:{ (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    self.image3.image = UIImage(data:imageData)
                    
                    i+=1;
                    self.pageControl.numberOfPages = i
                    self.pageControl.numberOfPages = i
                    self.imagesScrollView.contentSize = CGSize(width:self.imagesScrollView.frame.size.width * CGFloat(i),height:self.imagesScrollView.frame.size.height)
                    
                    
                } } })
        
        commentText.text = "\(eventObj[PLACE_DESCRIPTION]!)"
        addressLbl.text = "\(eventObj[PLACE_ADDRESS_STRING]!)"
        addPinOnMap(addressLbl.text!)
        
     

        let userPointer = eventObj[PLACE_USER] as! PFUser
        userPointer.fetchIfNeededInBackground { (user, error) in
            if error == nil {

    
            self.postLbl.text = userPointer.username!
            
            let str : String = (eventObj[PLACE_CATEGORY] as? String)!
            self.showCategory.text = str.replacingOccurrences(of: ",", with: " ,")
            
            }  else { self.simpleAlert("\(error!.localizedDescription)")}
        
         }
                
        }
    
    func addPinOnMap(_ address:String){
        
        mapView.delegate = self

        
        if mapView.annotations.count != 0{
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
            
        }
        
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = address
        localSearch = MKLocalSearch(request: localSearchRequest)
        
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil  {
                
                self.simpleAlert("เรายังไม่เจอสถานที่หรือGPSไม่ทำงาน")
                
//                let alert = UIAlertView(title: APP_NAME,
//                    message: "Place not found, or GPS not available",
//                    delegate: nil,
//                    cancelButtonTitle: "Try again" )
//                alert.show()
            }
                
                self.pointAnnotation = MKPointAnnotation()
                self.pointAnnotation.title = self.loadingTitle.text
                self.pointAnnotation.subtitle = self.addressLbl.text
            
                
                self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
                
            
                
                self.pinView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
                self.mapView.centerCoordinate = self.pointAnnotation.coordinate
                self.mapView.addAnnotation(self.pinView.annotation!)
                
                self.region = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, 1000, 1000);
                self.mapView.setRegion(self.region, animated: true)
                self.mapView.regionThatFits(self.region)
                self.mapView.reloadInputViews()
            }
            
            
            
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKPointAnnotation.self) {
            let userID = "CustomPinAnnotationViem"
            var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: userID)
            if annotView == nil {
                annotView = MKAnnotationView(annotation: annotation, reuseIdentifier: userID)
                annotView?.canShowCallout = true
                
                
                let imageView = UIImageView(frame: CGRect(x:0, y:0, width:66, height:66))
                imageView.image = UIImage(named: "locationPin")
                imageView.center = (annotView?.center)!
                imageView.contentMode = UIViewContentMode.scaleAspectFill
                annotView?.addSubview(imageView)
                
                let Button1 = UIButton(type: UIButtonType.custom)
                Button1.frame = CGRect(x:0, y:0, width:32, height:32)
                Button1.layer.cornerRadius = Button1.bounds.size.width/2
                Button1.clipsToBounds = true
                Button1.setImage(UIImage(named: "info"), for: UIControlState.normal)
                annotView?.rightCalloutAccessoryView = Button1
            }
            return annotView
            
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        annotation = view.annotation
        let coordinate = annotation.coordinate
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let map1 = MKMapItem(placemark: placemark)
        map1.name = annotation.title!
        map1.openInMaps(launchOptions: nil)
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        let pageWidth = imagesScrollView.frame.size.width
        
        let page = Int(floor((imagesScrollView.contentOffset.x * 2 + pageWidth) / (pageWidth * 2)))
        pageControl.currentPage = page
        
    }
 
    
    
    @IBAction func postBtn(_ sender: AnyObject) {
        
        let postVC = storyboard?.instantiateViewController(withIdentifier: "Post") as! Post
        
        navigationController?.pushViewController(postVC,animated:true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func facebookShare(sender: AnyObject) {
        
        var classif = PFObject(className: PLACE_CLASS_NAME)
        classif = singleArray[0] as! PFObject
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            socialController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            socialController.setInitialText("สถานที่พร้อมสำหรับคนพิการและคนทุกวัย คือ \(classif[PLACE_TITLE]!)")
            socialController.add(image1.image)
            socialController.add(image2.image)
            
            
            self.present(socialController, animated: true, completion: nil)
        } else {
            let alert: UIAlertView = UIAlertView(title: "Facebook", message: "กรุณา LogIn เข้าบัญชี Facebook ก่อนที่จะทำแชร์สถานที่นี้", delegate: self, cancelButtonTitle: "OK")
            //alert.show()
            
        }
        
        
        socialController.completionHandler = { result -> Void in
            var output = "การแชร์สถานที่สำเร็จแล้ว"
            switch result {
            case SLComposeViewControllerResult.cancelled: output = "ไม่สามารถแชร์สถานที่นี้ได้"; break
            case SLComposeViewControllerResult.done: output = "สถานที่นี้ได้ถูกโพสต์ใน Facebook ของคุณแล้ว"; break
            default: break
            }
            let alert = UIAlertView(title: "Facebook",
                                    message: output,
                                    delegate: nil,
                                    cancelButtonTitle: "OK")
            //alert.show()
        }
        
    }
    
    
    
    
}
