//
//  BrowsePlaceCell.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/1/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//

import UIKit
import Parse

class BrowsePlaceCell: UITableViewCell {

    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeImage.layer.cornerRadius = placeImage.bounds.size.width/2
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

