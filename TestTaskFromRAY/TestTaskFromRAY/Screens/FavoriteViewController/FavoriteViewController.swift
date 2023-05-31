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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel.imageModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? FavoriteTableViewCell,
              let imageModels = self.viewModel.imageModel else { return UITableViewCell() }
        let imageModel = imageModels[indexPath.row]
        
        cell.configure(model: imageModel)
        return cell
    }
    
    
}
