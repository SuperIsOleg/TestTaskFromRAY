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
        self.favoriteView.tableView.delegate = self
        self.favoriteView.tableView.dataSource = self
        self.favoriteView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        self.viewModel.delegate = self
    }
    
    internal func getAllItems() {
        self.viewModel.getAllItems()
    }
    
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel.imageModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? FavoriteTableViewCell,
              let imageModelArray = self.viewModel.imageModel else { return UITableViewCell() }
        let imageModel = imageModelArray[indexPath.row]
        
        cell.configure(model: imageModel)
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
}

// MARK: - FavoriteViewModelDelegate
extension FavoriteViewController: FavoriteViewModelDelegate {
    func reloadData() {
        self.favoriteView.tableView.reloadData()
    }
}

extension FavoriteViewController: FavoriteTableViewCellDelegate {
    func deleteButtonAction(indexPath: IndexPath?) {
        guard let indexPath = indexPath,
        var imageModelArray = self.viewModel.imageModel else { return }
        let imageModel = imageModelArray[indexPath.row]
        self.viewModel.imageModel?.remove(at: indexPath.row)
        self.viewModel.deleteItem(model: imageModel)
    }
    
}
