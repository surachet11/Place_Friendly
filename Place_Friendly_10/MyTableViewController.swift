//
//  MyTableViewController.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//


//
//  MyTableViewController.swift
//  ParseStarterProject
//
//  Created by Surachet Songsakaew on 8/21/2558 BE.
//  Copyright (c) 2558 Parse. All rights reserved.
//

import UIKit
import Parse


class MyTableViewController: UITableViewController {
    
    
    var placeArray = [PFObject]()
    
    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        placeArray.removeAll()
        
        let query = PFQuery(className: PLACE_CLASS_NAME)
        query.whereKey(PLACE_USER, equalTo:PFUser.current()!)
        query.order(byDescending: PLACE_UPDATED_AT)
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                
                
                self.placeArray = objects!
                self.tableView.reloadData()
                
                
                
                
                
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        self.placeArray.addObject(object)
//                    }
//                }
//                
//                self.tableView.reloadData()
            } else {
                self.simpleAlert("\(error!.localizedDescription)")

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "โพสต์ของฉันทั้งหมด"
        
              
        
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return placeArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MyCell", for: indexPath) as! MyTableViewCell
        
        var placeClass = PFObject(className: PLACE_CLASS_NAME)
        placeClass = placeArray[(indexPath as NSIndexPath).row]
        
        let imageFile = placeClass[PLACE_IMAGE1] as? PFFile
        imageFile?.getDataInBackground (block:{ (imageData,error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    cell.PlaceImg.image = UIImage(data: imageData)
                    
                }
            }
        })
        
        
        cell.PlaceTitlelb.text = "\(placeClass[PLACE_TITLE]!)"
        cell.PlaceDeslb.text = "\(placeClass[PLACE_DESCRIPTION]!)"
        cell.PlaceDeslb.isEditable = false

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

        var placeClass = PFObject(className: PLACE_CLASS_NAME)
        placeClass = placeArray[(indexPath as NSIndexPath).row]
        
        self.myTableView.reloadData()

        let postVC = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! Post
        postVC.placeClass = placeClass
        present(postVC, animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            var placeClass = PFObject(className: PLACE_CLASS_NAME)
            placeClass = placeArray[(indexPath as NSIndexPath).row]
            placeClass.deleteInBackground(block: { (success, error) -> Void in
                if error == nil {
                    self.placeArray.remove(at: (indexPath as NSIndexPath).row)
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                    self.myTableView.reloadData()
                    
//                    let alert = UIAlertView(title: APP_NAME,
//                        message: "Successfully deleted",
//                        delegate: nil,
//                        cancelButtonTitle: "OK" )
//                    alert.show()
                    
                    self.simpleAlert("Successfully deleted")

                    
                } else {
                    
                    self.simpleAlert("\(error!.localizedDescription)")
                }
            })
        }
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

