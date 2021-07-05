//
//  MMPhotoListViewModel.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation

class MMPhotoListViewModel: MMPhotoListViewModelContract {
    
    
    
    var model : MMPhotoListModel!
    var _view : MMPhotoListViewContract!
    
    required init(withView view: MMPhotoListViewContract, selectedAlbum: MMAlbumListModel.Album) {
        self._view = view
        
        model = MMPhotoListModel(selectedAlbum: selectedAlbum)
        
    }
    
    func loadData() {
        _view.showLoading()
        
        
        MMPlaceHolderManager.getPhotoInfoWithAlbumId(albumId: 2, onSuccess: { (response) in
            for i in response {
                
                
                MMPlaceHolderManager.getImageFromUrl(url: i.1["thumbnailUrl"].stringValue, result: { (image) in
                    if image != nil {
                        let new = MMPhotoListModel.PhotoList(image: image!,
                                                             title: i.1["title"].stringValue,
                                                             url: i.1["url"].stringValue,
                                                             thumbnailUrl: i.1["thumbnailUrl"].stringValue)
                        self.model.list.append(new)
                        DispatchQueue.main.async {
                            self._view.reloadList()
                            self._view.hideLoading()
                        }
                    }
                }, fail: { (error) in
                    DispatchQueue.main.async {
                        self._view.hideLoading()
                        self._view.showError(error?.localizedDescription ?? "Unknown error")
                    }
                    print(error?.localizedDescription ?? "Unknown error")
                })
            }
            
        }) { (error) in
            DispatchQueue.main.async {
                self._view.hideLoading()
                self._view.showError(error.localizedDescription)
                
            }
        }
    }
    
    func setIndexSelection(_ value: Int?) {
        model.indexSelectedPhoto = value
    }
    
}
