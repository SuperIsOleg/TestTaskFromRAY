//
//  FavoriteViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func getAllImages()
    func deleteImageModel(model: ImageModel)
}

protocol FavoriteViewModelDelegate: AnyObject {
    func reloadData()
}

final class FavoriteViewModel: FavoriteViewModelProtocol {

    private let coreDataManager = ImageCoreDataManager.shared
    internal var imageModel: [ImageModel]? {
        didSet {
            self.delegate?.reloadData()
        }
    }
    internal weak var delegate: FavoriteViewModelDelegate?
    
    internal func getAllImages() {
        let result = self.coreDataManager.getAllImages()
        switch result {
        case .success(let items):
            self.imageModel = items
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
   internal func deleteImageModel(model: ImageModel) {
       self.coreDataManager.deleteImageModel(item: model)
    }
    
}
