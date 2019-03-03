//
//  PodcastSearchController.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/2/13.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import UIKit

class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    let podcasts = [
        Podcast(name: "Let's build that app", artistName: "AndyChung"),
        Podcast(name: "Flip Radio", artistName: "John")
    ]
    let cellId = "cellId"
    
    // Implement a UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    // MARK:- Setup work
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // implement Alamofire to search iTunes API
    }
    
    // MARK:- UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }
}
