//
//  ShowCategory.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/5/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//

import UIKit
import Parse

class ShowCategory: UITableViewController {
    
    var placeArray = NSMutableArray()
    var categoryArray = [PFObject]()
    var placeName: String = ""
    var itemCount : NSInteger = 0



    override func viewDidLoad() {
        super.viewDidLoad()

        
   
    
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
   

        queryCategory()



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return self.placeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
     
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPlaceCell", for: indexPath) as! ShowCell
        
        var placeClass = PFObject(className: PLACE_CLASS_NAME)
        placeClass = placeArray[indexPath.row] as! PFObject
        
        let imageFile = placeClass[PLACE_IMAGE1] as? PFFile
        imageFile?.getDataInBackground{ (imageData,error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    cell.showImage.image = UIImage(data: imageData)
                    
                }
            }
        }
    
    
        cell.showTitle.text = "\(placeClass[PLACE_TITLE]!)"
        
       
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        var placeClass = PFObject(className: PLACE_CLASS_NAME)
        placeClass = placeArray[indexPath.row] as! PFObject
        

        
        let showPlaceVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowSinglePlace") as! ShowSinglePlace
        
        //showPlaceVC.eventObj = placeClass
        showPlaceVC.singleID = placeClass.objectId!
        self.navigationController?.pushViewController(showPlaceVC, animated: true)
       
    }
    
    

        func queryCategory() {
            placeArray.removeAllObjects()
            showHUD()
    
            let itemCount = 0
    
    
            let query = PFQuery(className:PLACE_CLASS_NAME)
            
            
            query.whereKey(PLACE_CATEGORY, contains: categoriesArray[itemCount])
            query.order(byAscending: PLACE_UPDATED_AT)
            query.limit = 20
    
    
            query.findObjectsInBackground { (objects, error) -> Void in
                if error == nil {
                   
                    if let objects = objects as [PFObject]! {
                        for object in objects {
                            self.placeArray.add(object)
                            
                        }
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
    
                    self.simpleAlert("\(error!.localizedDescription)")
                    }
                
                self.hideHUD()
            }
            
            
            
                
            }
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
