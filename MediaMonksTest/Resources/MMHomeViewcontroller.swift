//
//  ViewController.swift
//  MediaMonksTest
//
//  Created by iMac on 14/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import UIKit

class MMHomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    @IBAction func albumListButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segue_to_album_list", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Home"
        
        titleLabel.alpha = 1
        let titleFrom = view.frame.width
        let titleTo = titleLabel.frame.origin.x
        titleLabel.slide(fromX: titleFrom, toX: titleTo, duration: 0.7)
        
        subtitleLabel.alpha = 1
        let subFrom = -subtitleLabel.frame.width*2
        let subTo = subtitleLabel.frame.origin.x
        subtitleLabel.slide(fromX: subFrom, toX: subTo, duration: 0.7)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MMAlbumListViewController {
            controller.viewModel = MMAlbumListViewModel(withView: controller)
        }
    }
}

