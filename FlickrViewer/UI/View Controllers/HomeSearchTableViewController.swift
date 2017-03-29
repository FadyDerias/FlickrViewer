//
//  HomeSearchTableViewController.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import UIKit

class HomeSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var flickrSearchBar: UISearchBar!
    let searchTableViewCellIdentifier = "SearchTableViewCellIdentifier"
    var searchPhotosResults: [FLPhoto]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoManager = FLPhotosManager()
        photoManager.fetchPhotosBySearch(page: 1, userText: "Flower", perPage: 20, success: { (photosResult) in
            self.searchPhotosResults = photosResult.photosList?.photos
            OperationQueue.main.addOperation({
                self.tableView.reloadData()
            })
        }) { (error) in
            print(error)
        }
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRows = searchPhotosResults?.count else {
            return 0
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: searchTableViewCellIdentifier) as! SearchTableViewCell
        
        return cell
    }

}
