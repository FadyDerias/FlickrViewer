//
//  HomeSearchTableViewController.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import UIKit
import CoreData

class HomeSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var flickrSearchBar: UISearchBar!
    let flickrPhotoTableViewCellIdentifier = "FlickrPhotoTableViewCellIdentifier"
    var searchPhotosResults = NSMutableArray()
    var userInputSearchText: String?
    var previousUserInputSearchText: String?
    var nextPageToLoad: Int?
    var context = FLCoreDataStack.sharedInstance.managedObjectContext
    var isExecutingNewSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        self.setNavigationBarTitle(title: "Flickr Photos Search App")
        setupFlickrSearchBar()
        loadSearchQueriesFromUserDefaults()
        loadDataSourceFromCoreData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchPhotosResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: flickrPhotoTableViewCellIdentifier, for: indexPath) as!FlickrPhotoTableViewCell
        cell.prepareDisclosureIndicator()
        let flPhoto = searchPhotosResults.object(at: indexPath.row) as! FLPhoto
        cell.configureForFlickrPhotoData(flPhoto: flPhoto)
        
        return cell
    }
    
    func  resetTableView() {
        if(searchPhotosResults.count > 0) {
            let flPhotos = FLCoreDataManager.sharedInstance.performActionForPhotosResultsInCoreData(deleteCoreData: true)
            
            if (flPhotos == nil) {
                searchPhotosResults.removeAllObjects()
            }
        }
        
        isExecutingNewSearch = false
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (searchPhotosResults.count - 1)) {
            if(nextPageToLoad != nil) {
                nextPageToLoad! += 1
            }
            
            loadResultsForUserInputSearchText()
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserPhotosSegueIdentifier" {
            let userPhotosTableViewController = segue.destination as! UserPhotosTableViewController
            userPhotosTableViewController.userId = sender as? String
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flPhoto = searchPhotosResults.object(at: indexPath.row) as! FLPhoto
        let userId = flPhoto.ownerId
        performSegue(withIdentifier: "ShowUserPhotosSegueIdentifier", sender: userId)
    }
    
    //MARK: - UISearchBarSetup
    
    func setupFlickrSearchBar() {
        flickrSearchBar.delegate = self
        flickrSearchBar.updateFontColorForSearchText()
    }
    
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text ?? ""
        
        if(searchText != previousUserInputSearchText) {
            userInputSearchText = searchText
            isExecutingNewSearch = true
            self.nextPageToLoad = 1
            loadResultsForUserInputSearchText()
        }
        
        searchBar.resignFirstResponder()
    }
    

    
    //MARK: - UserDefaults
    
    func loadSearchQueriesFromUserDefaults() {
        if let defaultSearchParametersDictionary = FLUserDefaultsManager.sharedInstance.loadSearchParametersFromUserDefaults() {
            nextPageToLoad = defaultSearchParametersDictionary[FLUserDefaultsManager.sharedInstance.pageToLoadKey] as? Int
            userInputSearchText = defaultSearchParametersDictionary[FLUserDefaultsManager.sharedInstance.userSearchTextKey] as? String
            previousUserInputSearchText = defaultSearchParametersDictionary[FLUserDefaultsManager.sharedInstance.userPreviousSearchTextKey] as? String
        } else {
            nextPageToLoad = 1
        }
    }
    
    //MARK: - CoreData
    
    func loadDataSourceFromCoreData() {
        
        if let flPhotos = FLCoreDataManager.sharedInstance.performActionForPhotosResultsInCoreData(deleteCoreData: false) {
            searchPhotosResults.addObjects(from: flPhotos)
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: - NetworkRequest
    
    func loadResultsForUserInputSearchText() {
        
        let photoManager = FLPhotosManager()
        
        if let searchText = self.userInputSearchText, let pageToLoadNumber = self.nextPageToLoad {
            photoManager.fetchPhotosBySearch(page: pageToLoadNumber, userText: searchText, userId: nil, success: { (photosResult) in
                
                if(self.isExecutingNewSearch) {
                    self.resetTableView()
                }
                
                self.previousUserInputSearchText = searchText
                if let photos = photosResult.photosList?.photos {
                    self.searchPhotosResults.addObjects(from: photos)
                    
                    OperationQueue.main.addOperation({
                        
                        FLUserDefaultsManager.sharedInstance.saveSearchParametersInUserDefaults(nextPageToLoad: pageToLoadNumber, userInputSearchText: searchText, userPreviousSearchText: searchText)
                        
                        if (photos.count == 0)
                        {
                            let noResultsAlertController = UIAlertController.searchResultsAlertController()
                            self.present(noResultsAlertController, animated: true, completion: nil)
                        } else {
                            
                            for photo in photos {
                                FLCoreDataManager.sharedInstance.savePhotoToCoreData(flPhoto: photo)
                            }
                            
                            self.tableView.reloadData()
                        }
                    })
                }
                
            }) { (error) in
                print(error)
                let noInternetConnectionAlertController = UIAlertController.defaultNetworkingAlertController({ 
                    self.loadResultsForUserInputSearchText()
                }, {
                    self.loadSearchQueriesFromUserDefaults()
                })
                OperationQueue.main.addOperation({
                    self.present(noInternetConnectionAlertController, animated: true, completion: nil)
                })
                
            }
        }
    }
    
}
