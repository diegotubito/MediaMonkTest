//
//  MMAlbumListModel.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import SwiftyJSON

class MMAlbumListModel {
    var albums = [Album]()
    var selectedAlbumIndex : Int?
    
    init(albumsData: [JSON]) {
        for i in albumsData {
            let new = Album(id: i["id"].intValue, title: i["title"].stringValue, userID: i["userID"].intValue)
            albums.append(new)
        }
        
    }
    
    class Album {
        var id : Int
        var title : String
        var userID : Int
        
        init(id: Int, title: String, userID: Int) {
            self.id = id
            self.title = title
            self.userID = userID
        }
    }
    
    
}

