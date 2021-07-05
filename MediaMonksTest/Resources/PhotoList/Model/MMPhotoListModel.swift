//
//  MMPhotoListModel.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MMPhotoListModel {
    var selectedAlbum : MMAlbumListModel.Album
    var indexSelectedPhoto : Int?
    var list = [PhotoList]()
    
    init(selectedAlbum: MMAlbumListModel.Album) {
        self.selectedAlbum = selectedAlbum
    }
    
    class PhotoList {
        var image : UIImage
        var title : String
        var url : String
        var thumbnailUrl : String
        
        init(image: UIImage, title: String, url: String, thumbnailUrl: String) {
            self.image = image
            self.title = title
            self.url = url
            self.thumbnailUrl = thumbnailUrl
        }
    }
}
