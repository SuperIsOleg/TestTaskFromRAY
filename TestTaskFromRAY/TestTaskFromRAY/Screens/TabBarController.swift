//
//  TabBarController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

final class TabBarController: UITabBarController {
    let searchViewController = SearchViewController()
    let favoriteViewController = FavoriteViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.prepareTabBarItems()
    }
    
    private func prepareTabBarItems() {
        searchViewController.tabBarItem = UITabBarItem(title: "Search",
                                                       image: UIImage(systemName: "magnifyingglass.circle"),
                                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite",
                                                      image: UIImage(systemName: "star"),
                                                      selectedImage:UIImage(systemName: "star.fill"))
      
        self.viewControllers = [
            searchViewController, favoriteViewController
        ]
    }
    
}
