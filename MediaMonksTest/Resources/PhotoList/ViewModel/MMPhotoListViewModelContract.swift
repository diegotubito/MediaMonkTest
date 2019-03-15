//
//  MMPhotoListViewModelContract.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation

protocol MMPhotoListViewModelContract {
    init(withView view: MMPhotoListViewContract, selectedAlbum: MMAlbumListModel.Album)
    var model : MMPhotoListModel! {get}
    
    func loadData()
    func setIndexSelection(_ value: Int?)
}

protocol MMPhotoListViewContract {
    func showError(_ message: String)
    func reloadList()
    func showLoading()
    func hideLoading()
}

