//
//  FavoriteViewController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var favoriteView = FavoriteView()
    
    override func loadView() {
        super.loadView()
        self.view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
