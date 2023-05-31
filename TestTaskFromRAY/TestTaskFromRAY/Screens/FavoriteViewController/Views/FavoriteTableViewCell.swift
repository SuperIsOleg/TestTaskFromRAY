//
//  FavoriteTableViewCell.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: FavoriteTableViewCell.self)
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .systemGray5
        self.contentView.addSubview(favoriteImageView)
        
        NSLayoutConstraint.activate([
            // setup constraints for favoriteImageView
            favoriteImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            favoriteImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25),
            favoriteImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -25),
            favoriteImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    internal func configure(model: ImageModel) {
        guard let data = model.imageData else { return }
        self.favoriteImageView.image = UIImage(data: data)
    }
}

