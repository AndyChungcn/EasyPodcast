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
    }
    
    // MARK:- Setup Function
    
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

