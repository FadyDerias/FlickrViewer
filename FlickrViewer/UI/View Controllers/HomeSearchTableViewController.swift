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
    var userInputSearchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickrSearchBar.delegate = self
        flickrSearchBar.becomeFirstResponder()
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
    
    //MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userInputSearchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadResultsForUserInputSearchText()
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Network Request
    
    func loadResultsForUserInputSearchText() {
        let photoManager = FLPhotosManager()
        if let searctText = self.userInputSearchText {
            photoManager.fetchPhotosBySearch(page: 1, userText: searctText, perPage: 20, success: { (photosResult) in
                self.searchPhotosResults = photosResult.photosList?.photos
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }) { (error) in
                print(error)
            }
        }


    }

}
