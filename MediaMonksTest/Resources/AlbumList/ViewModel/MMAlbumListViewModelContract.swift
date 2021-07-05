//
//  MMAlbumListViewModelContract.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation

protocol MMAlbumListViewModelContract {
    init (withView view: MMAlbumListViewContract)
    var model : MMAlbumListModel! {get}
    func loadData()
    func getAlbumCount() -> Int
    func getSelectedAlbum() -> MMAlbumListModel.Album
    func setIndexSelectedAlbum(_ value: Int)
}

protocol MMAlbumListViewContract {
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func reloadList()
}

