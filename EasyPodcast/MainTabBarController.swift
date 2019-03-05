//
//  MainTabBarController.swift
//  EasyPodcast
//
//  Created by 钟汇杭 on 2019/2/12.
//  Copyright © 2019 钟汇杭. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        UINavigationBar.appearance().prefersLargeTitles = true
        
        setupViewControllers()
        setupPlayerDetailsView()
    }
    
    @objc func minimizePlayerDetails() {
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
            
            self.playerDetailsView.maximizedStackView.alpha = 0
            self.playerDetailsView.miniPlayerView.alpha = 1
        })
    }
    
    func maximizePlayerDetails(episode: Episode?) {
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        minimizedTopAnchorConstraint.isActive = false
        
        if episode != nil {
            playerDetailsView.episode = episode
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
        })
    }
    
    // MARK:- Setup Function
    
    var playerDetailsView = PlayerDetailsView.initFromNib()
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsView() {
        print("Setting up PlayerDetailsView")
        
        // use auto layout
        // view.addSubview(playerDetailsView)
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        // enables auto layout
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        
        maximizedTopAnchorConstraint.isActive = true
        
        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupViewControllers() {
        viewControllers = [
            generateNavController(for: PodcastSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavController(for: ViewController(), title: "Favorite", image: #imageLiteral(resourceName: "favorites")),
            generateNavController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    // MARK:- Helper Functions
    
    fileprivate func generateNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        //        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}

