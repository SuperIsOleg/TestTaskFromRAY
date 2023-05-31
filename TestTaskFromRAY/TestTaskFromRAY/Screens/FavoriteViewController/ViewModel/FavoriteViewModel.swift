//
//  FavoriteViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func getAllItems()
    func deleteItem(model: ImageModel)
}

protocol FavoriteViewModelDelegate: AnyObject {
    func reloadData()
}

final class FavoriteViewModel: FavoriteViewModelProtocol {

    private let coreDataManager = CoreDataManager.shared
    internal var imageModel: [ImageModel]? {
        didSet {
            self.delegate?.reloadData()
        }
    }
    internal weak var delegate: FavoriteViewModelDelegate?
    
    internal func getAllItems() {
      let result = self.coreDataManager.getAllItems()
        switch result {
        case .success(let items):
            self.imageModel = items
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
   internal func deleteItem(model: ImageModel) {
       self.coreDataManager.deleteItem(item: model)
    }
    
}
