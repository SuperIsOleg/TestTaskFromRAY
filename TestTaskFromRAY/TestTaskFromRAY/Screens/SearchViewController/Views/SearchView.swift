//
//  SearchView.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchAction()
    func addToFavoriteAction()
}

final class SearchView: UIView {
    
    private let resultImageView: UIImageView = {
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
    
    private let limitedRequestLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.backgroundColor = .white
        textField.placeholder = "Search ..."
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.isEnabled = false
        var configure = UIButton.Configuration.filled()
        configure.buttonSize = .large
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorite", for: .normal)
        button.isEnabled = false
        var configure = UIButton.Configuration.filled()
        configure.buttonSize = .large
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    internal weak var delegate: SearchViewDelegate?
    
    internal var textField: BaseTextField {
        get {
            return searchTextField
        }
    }
    
    internal var imageView: UIImageView {
        get {
            return resultImageView
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.backgroundColor = .systemGray5
        
        self.addSubview(resultImageView)
        self.addSubview(limitedRequestLabel)
        self.addSubview(searchTextField)
        self.addSubview(searchButton)
        self.addSubview(addFavoriteButton)
        
        NSLayoutConstraint.activate([
            // setup constraints for resultImageView
            resultImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 25),
            resultImageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -25),
            resultImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // setup constraints for limitedRequestLabel
            limitedRequestLabel.topAnchor.constraint(equalTo: self.resultImageView.bottomAnchor, constant: 15),
            limitedRequestLabel.leftAnchor.constraint(equalTo: self.resultImageView.leftAnchor),
            
            // setup constraints for searchTextField
            searchTextField.topAnchor.constraint(equalTo: self.limitedRequestLabel.bottomAnchor, constant: 25),
            searchTextField.leftAnchor.constraint(equalTo: self.resultImageView.leftAnchor),
            searchTextField.rightAnchor.constraint(equalTo: self.resultImageView.rightAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            // setup constraints for searchButton
            searchButton.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 25),
            searchButton.leftAnchor.constraint(equalTo: self.searchTextField.leftAnchor),
            searchButton.rightAnchor.constraint(equalTo: self.searchTextField.rightAnchor),
            
            // setup constraints for searchButton
            addFavoriteButton.topAnchor.constraint(equalTo: self.searchButton.bottomAnchor, constant: 15),
            addFavoriteButton.leftAnchor.constraint(equalTo: self.searchButton.leftAnchor),
            addFavoriteButton.rightAnchor.constraint(equalTo: self.searchButton.rightAnchor),
        ])
        
        searchButton.addTarget(self, action: #selector(searchButtonTap), for: .touchUpInside)
        addFavoriteButton.addTarget(self, action: #selector(addFavoriteButtonTap), for: .touchUpInside)
    }
    
    internal func setImage(data: Data) {
        self.resultImageView.image = UIImage(data: data)
    }
    
    internal func setSearchButtonEnabled(ifNeeded: Bool) {
        self.searchButton.isEnabled = !ifNeeded
    }
    
    internal func setAddFavoriteButtonEnabled(ifNeeded: Bool) {
        self.addFavoriteButton.isEnabled = !ifNeeded
    }
    
    internal func setLimit(count: Int) {
        self.limitedRequestLabel.text = "Request limit: \(count)"
    }
    
    @objc
    private func searchButtonTap() {
        self.delegate?.searchAction()
    }
    
    @objc
    private func addFavoriteButtonTap() {
        self.delegate?.addToFavoriteAction()
    }
}
