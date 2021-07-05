//
//  MMTableViewCellAlbumListBody.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class MMTableViewCellAlbumListBody: UITableViewCell {
    
    @IBOutlet weak var titleCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
