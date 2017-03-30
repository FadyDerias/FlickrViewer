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
    var searchPhotosResults = NSMutableArray()
    var userInputSearchText: String?
    var nextPagetoLoad: Int = 1
    
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
        
        return searchPhotosResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: searchTableViewCellIdentifier) as! SearchTableViewCell
        let flPhoto = searchPhotosResults.object(at: indexPath.row) as! FLPhoto
        cell.configureForFlickrPhotoData(flPhoto: flPhoto)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (searchPhotosResults.count - 1)) {
            nextPagetoLoad += 1
            loadResultsForUserInputSearchText()
        }
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userInputSearchText = searchText
        searchPhotosResults.removeAllObjects()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadResultsForUserInputSearchText()
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Network Request
    
    func loadResultsForUserInputSearchText() {
        let photoManager = FLPhotosManager()
        if let searctText = self.userInputSearchText {
            photoManager.fetchPhotosBySearch(page: 1, userText: searctText, perPage: 10, success: { (photosResult) in
                
                if let photos = photosResult.photosList?.photos {
                    self.searchPhotosResults.addObjects(from: photos)
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }) { (error) in
                print(error)
            }
        }


    }

}
