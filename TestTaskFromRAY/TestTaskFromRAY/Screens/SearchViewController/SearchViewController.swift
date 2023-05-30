//
//  SearchViewController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var searchView = SearchView()
    
    override func loadView() {
        super.loadView()
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

