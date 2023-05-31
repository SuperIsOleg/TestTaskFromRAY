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
                                                       tag: 0)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite",
                                                         image: UIImage(systemName: "star"),
                                                         tag: 1)
        
        self.viewControllers = [
            searchViewController, favoriteViewController
        ]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            self.favoriteViewController.getAllItems()
        default:
            break
        }
    }
    
}
