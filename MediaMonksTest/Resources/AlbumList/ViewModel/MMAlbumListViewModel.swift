//
//  MMAlbumListViewModel.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation

class MMAlbumListViewModel: MMAlbumListViewModelContract {
    
    
    var model: MMAlbumListModel!
    var _view : MMAlbumListViewContract!
    
    required init(withView view: MMAlbumListViewContract) {
        _view = view
    }
    
    func loadData() {
        _view.showLoading()
        MMPlaceHolderManager.getAlbums(onSuccess: { (albumResponse) in
            self.model = MMAlbumListModel(albumsData: albumResponse.array!)
            
            DispatchQueue.main.async {
                self._view.reloadList()
                self._view.hideLoading()
            }
            
        }) { (albumError) in
            DispatchQueue.main.async {
                self._view.hideLoading()
                self._view.showError(albumError.localizedDescription)
            }
        }
    }
    
    func getAlbumCount() -> Int {
        
        guard model != nil else { return 0}
        return model.albums.count
        
    }
    
    func getSelectedAlbum() -> MMAlbumListModel.Album {
        return model.albums[model.selectedAlbumIndex!]
    }
    
    func setIndexSelectedAlbum(_ value: Int) {
        model.selectedAlbumIndex = value
    }
    
}
