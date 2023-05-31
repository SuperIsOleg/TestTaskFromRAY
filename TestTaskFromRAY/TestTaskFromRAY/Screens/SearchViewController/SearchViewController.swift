//
//  SearchViewController.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchView.delegate = self
        self.searchView.textField.delegate = self
    }
    
    private func getImage(text: String) {
        let imageFrame = self.searchView.imageView.frame
        
        Task(priority: .background, operation: {
            let result = await self.viewModel.getImage(height: imageFrame.height,
                                                 width: imageFrame.width,
                                                 text: text)
            switch result {
            case .success(let model):
                self.searchView.setImage(data: model.imageData)
            case .failure(let error):
                self.showError(error.localizedDescription, nil, okCompletion: {})
            }
        })
    }
    
}

// MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchAction() {
        guard let text = self.searchView.textField.text else { return }
        self.getImage(text: text)
        self.searchView.textField.resignFirstResponder()
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
