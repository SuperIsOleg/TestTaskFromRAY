//
//  FavoriteTableViewCell.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

protocol FavoriteTableViewCellDelegate: AnyObject {
    func deleteButtonAction(indexPath: IndexPath?)
}

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
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.isUserInteractionEnabled = true
        var configure = UIButton.Configuration.plain()
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let linkTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .systemGray5
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    internal var indexPath: IndexPath?
    internal weak var delegate: FavoriteTableViewCellDelegate?
    internal var textView: UITextView {
        get {
            return linkTextView
        }
    }
    
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
        self.contentView.addSubview(deleteButton)
        self.contentView.addSubview(linkTextView)
        
        NSLayoutConstraint.activate([
            // setup constraints for favoriteImageView
            favoriteImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            favoriteImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25),
            favoriteImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -25),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // setup constraints for deleteButton
            deleteButton.topAnchor.constraint(equalTo: self.favoriteImageView.topAnchor, constant: 10),
            deleteButton.rightAnchor.constraint(equalTo: self.favoriteImageView.rightAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            
            linkTextView.topAnchor.constraint(equalTo: self.favoriteImageView.bottomAnchor, constant: 5),
            linkTextView.leftAnchor.constraint(equalTo: self.favoriteImageView.leftAnchor),
            linkTextView.rightAnchor.constraint(equalTo: self.favoriteImageView.rightAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        self.deleteButton.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
    }
    private func mutableString(url: URL) {
        linkTextView.text = url.absoluteString

        linkTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 14),
            .link: url
        ]
    }
    
    internal func configure(model: ImageModel) {
        guard let data = model.imageData,
              let url = model.imageUrl else { return }
        self.favoriteImageView.image = UIImage(data: data)
        self.mutableString(url: url)
    }
    
    @objc
    private func deleteButtonTap() {
        self.delegate?.deleteButtonAction(indexPath: self.indexPath)
    }
}

