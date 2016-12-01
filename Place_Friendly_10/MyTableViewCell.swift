//
//  MyTableViewCell.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//



import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var PlaceImg: UIImageView!
    
    @IBOutlet weak var PlaceTitlelb: UILabel!
    
    @IBOutlet weak var PlaceDeslb: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
