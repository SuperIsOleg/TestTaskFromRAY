//
//  FavoriteView.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

final class FavoriteView: UIView {
    
    private let favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    internal var tableView: UITableView {
        get {
            return favoriteTableView
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(favoriteTableView)
        
        NSLayoutConstraint.activate([
            // setup constraints for favoriteTableView
            favoriteTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            favoriteTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            favoriteTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            favoriteTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
}
