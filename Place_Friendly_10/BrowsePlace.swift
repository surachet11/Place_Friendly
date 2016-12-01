//
//  BrowsePlace.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit
import Parse


var placeArray = NSMutableArray()
var searchedAdsArray = [PFObject]()


class BrowsePlace: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.title = "หมวดหมู่ทั้งหมด"
        
    }
    
    

    
//
//    @IBAction func postBtn(sender: AnyObject) {
//        
//        
//        let postVC = self.storyboard?.instantiateViewControllerWithIdentifier("Post") as! Post
//        
//        presentViewController(postVC,animated:true,completion:nil)
//
//    }
//    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
   override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return categoriesArray.count
    }
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowsePlaceCell", for : indexPath) as! BrowsePlaceCell
        
        let imageName = UIImage(named: categoriesArray[indexPath.row])
        cell.placeImage.image = imageName
  
        
        cell.placeTitle.text = "\(categoriesArray[indexPath.row])"
        
       
        return cell
    }
    

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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//        if(segue.identifier == "abc") {
//
//            if let indexPath = tableView.indexPathForSelectedRow{
//                let detailsVC = segue.destination as! ShowCategory
//                
//                detailsVC.navigationItem.title = (sender as AnyObject).placeTitle!.text!
//                detailsVC.itemCount = indexPath.row
//            }
//        }
//    }
//    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "abc") {
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let vc  = segue.destination as! ShowCategory
                
                print(categoriesArray[indexPath.row])
                
                print(indexPath.row)
                
                
                
                vc.placeName = categoriesArray[indexPath.row]
                
                let cell = sender as! UITableViewCell
                vc.navigationItem.title = cell.textLabel?.text
                
                print("ชื่อ..\(cell)")
                
                
            }
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var classifClass = PFObject(className: PLACE_CLASS_NAME)
//        classifClass = searchedAdsArray[(indexPath as NSIndexPath).row]
//        
//        let showAdVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowCategory") as! ShowCategory
//        // Pass the Ad Object to the Controller
//        showAdVC.singleAdObj = classifClass
//        self.navigationController?.pushViewController(showAdVC, animated: true)
//    }
//    
    
}
