//
//  MMPhotoListViewController.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit


class MMPhotoListViewController : UIViewController, MMPhotoListViewContract {
    
    
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    var detailPhotoView : MLPopUpCustomView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : MMPhotoListViewModelContract!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.register(MMTableViewCellPhotoList.nib, forCellReuseIdentifier: MMTableViewCellPhotoList.identifier)
        
        
        viewModel.loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Photo List"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async {
            self.showPopUpPhotoDetailView()
        }
        
    }
    
    
    func showError(_ message: String) {
        alertMessage(title: "Error", message: message)
    }
    
    func reloadList() {
        tableView.reloadData()
    }
    
    func showLoading() {
        myActivityIndicator.startAnimating()
    }
    
    func hideLoading() {
        myActivityIndicator.stopAnimating()
    }
    
}


extension MMPhotoListViewController {
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MMPhotoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MMTableViewCellPhotoList.identifier, for: indexPath) as? MMTableViewCellPhotoList{
            
            cell.viewCell.image = viewModel.model.list[indexPath.row].image
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension MMPhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setIndexSelection(indexPath.row)
        showPopUpPhotoDetailView()
        
    }
    
    func showPopUpPhotoDetailView() {
        if viewModel.model.indexSelectedPhoto == nil {return}
        
        if detailPhotoView != nil {
            detailPhotoView.removeFromSuperview()
        }
        detailPhotoView = MLPopUpCustomView(frame: CGRect.zero)
        detailPhotoView.initialize()
        detailPhotoView.delegate = self
        view.addSubview(detailPhotoView)
        
        detailPhotoView.translatesAutoresizingMaskIntoConstraints = false
        detailPhotoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailPhotoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        detailPhotoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        detailPhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.detailPhotoView.showData(data: self.viewModel.model.list[viewModel.model.indexSelectedPhoto!])
    }
    
    
    
}


extension MMPhotoListViewController: MLPopUpCustomViewDelegate {
    func finishedView() {
        viewModel.setIndexSelection(nil)
    }
    
    
}
