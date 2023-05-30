//
//  SearchViewController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchView = SearchView()
    
    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.delegate = self
        self.searchView.textField.delegate = self
    }
    
    
}

// MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchAction() {
        guard let text = self.searchView.textField.text else { return }
        self.searchView.textField.text = nil
    }
    
    func addToFavoriteAction() { }
    
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
