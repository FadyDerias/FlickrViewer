//
//  UserPhotosTableViewController.swift
//  FlickrViewer
//
//  Created by Fady on 3/31/17.
//  Copyright © 2017 orange. All rights reserved.
//

import UIKit

class UserPhotosTableViewController: UITableViewController {
    
    var searchPhotosResults = NSMutableArray()
    let userPhotoTableViewCellIdentifier = "UserPhotoTableViewCellIdentifier"
    var userId: String?
    var nextPageToLoad: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTitle(title: "More Photos For Selected User")
        self.tableView.tableFooterView = UIView()
        loadResultsForUserId()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchPhotosResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: userPhotoTableViewCellIdentifier, for: indexPath) as!UserPhotoTableViewCell
        
        let flPhoto = searchPhotosResults.object(at: indexPath.row) as! FLPhoto
        cell.configureForFlickrPhotoData(flPhoto: flPhoto)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (searchPhotosResults.count - 1)) {
            nextPageToLoad += 1
            loadResultsForUserId()
        }
    }
    
    // MARK: NetworkRequest
    
    func loadResultsForUserId() {
        let photoManager = FLPhotosManager()
        if let ownerId = self.userId {
            photoManager.fetchPhotosBySearch(page: nextPageToLoad, userText: nil, userId: ownerId, success: { (photosResult) in
                
                if let photos = photosResult.photosList?.photos {
                    self.searchPhotosResults.addObjects(from: photos)
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                    
                    if (self.searchPhotosResults.count == 0)
                    {
                        let noResultsAlertController = UIAlertController.searchResultsAlertController()
                        self.present(noResultsAlertController, animated: true, completion: nil)
                    }
                })
            }) { (error) in
                print(error)
                
                let noInternetConnectionAlertController = UIAlertController.defaultNetworkingAlertController({ 
                    self.loadResultsForUserId()
                }, {
                    if(self.nextPageToLoad > 1) {
                        self.nextPageToLoad -= 1
                    }
                })
                
                OperationQueue.main.addOperation({
                    self.present(noInternetConnectionAlertController, animated: true, completion: nil)
                })
            }
        }
    }

}
