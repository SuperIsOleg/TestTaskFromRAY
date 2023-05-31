//
//  FavoriteViewController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    private lazy var favoriteView = FavoriteView()
    private let viewModel = FavoriteViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getAllItems()
    }

}
