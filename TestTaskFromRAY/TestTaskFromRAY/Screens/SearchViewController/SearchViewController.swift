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
        self.searchView.setLimit(count: self.viewModel.requestLimi)
    }
    
    private func getImage(text: String, completion: @escaping () -> Void) {
        let imageFrame = self.searchView.imageView.frame
        
        Task(priority: .background, operation: {
            let result = await self.viewModel.getImage(height: imageFrame.height,
                                                       width: imageFrame.width,
                                                       text: text)
            switch result.0 {
            case .success(let data):
                self.viewModel.imageData = data
                self.viewModel.imageUrl = result.url
                completion()
            case .failure(let error):
                self.showAlert("the text must be in english and not contain a space",
                               error.localizedDescription, okCompletion: {})
            }
        })
    }
    
}

// MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchAction() {
        guard let text = self.searchView.textField.text, !text.isEmpty else {
            return self.showAlert("the text must be in english and not contain a space", "Enter text", okCompletion: {})
        }
        
        if self.viewModel.requestLimi != 0  {
            self.getImage(text: text, completion: {
                guard let data = self.viewModel.imageData else { return }
                self.searchView.setImage(data: data)
                self.searchView.setAddFavoriteButtonEnabled(ifNeeded: self.searchView.imageView.image == nil)
            })
            self.viewModel.requestLimi -= 1
        } else {
            self.showAlert("Request limit exceeded", nil, okCompletion: {})
        }
        
        self.searchView.setLimit(count: self.viewModel.requestLimi)
        self.searchView.textField.resignFirstResponder()
        self.searchView.setSearchButtonEnabled(ifNeeded: true)
        self.searchView.textField.text = nil
    }
    
    func addToFavoriteAction() {
        self.viewModel.createItem()
        self.viewModel.imageData = nil
        self.searchView.setImage(data: Data())
        self.searchView.setAddFavoriteButtonEnabled(ifNeeded: true)
        self.showAlert("Picture successfully added to favorites")
    }
    
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return self.searchView.setSearchButtonEnabled(ifNeeded: true)
        }
        self.searchView.setSearchButtonEnabled(ifNeeded: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
