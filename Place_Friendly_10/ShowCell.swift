//
//  ShowCell.swift
//  Place_Freindly
//
//  Created by Surachet Songsakaew on 9/5/2558 BE.
//  Copyright (c) 2558 Surachet Songsakaew. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {

    
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
