//
//  MMAlbumListViewController.swift
//  MediaMonksTest
//
//  Created by David Diego Gomez on 14/3/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class MMAlbumListViewController: UIViewController, MMAlbumListViewContract {
    
    var viewModel : MMAlbumListViewModelContract!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(MMTableViewCellAlbumListBody.nib, forCellReuseIdentifier: MMTableViewCellAlbumListBody.identifier)
        viewModel.loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Album List"
    }
    
    func showError(_ message: String) {
        alertMessage(title: "Error", message: message)
    }
    
    func showLoading() {
        myActivityIndicator.startAnimating()
    }
    
    func hideLoading() {
        myActivityIndicator.stopAnimating()
    }
    
    func reloadList() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}

extension MMAlbumListViewController {
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}



extension MMAlbumListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAlbumCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MMTableViewCellAlbumListBody.identifier, for: indexPath) as? MMTableViewCellAlbumListBody{
            
            cell.titleCell.text = viewModel.model.albums[indexPath.row].title
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension MMAlbumListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setIndexSelectedAlbum(indexPath.row)
        performSegue(withIdentifier: "segue_to_photo_list", sender: nil)
        
    }
    
    
}
