//
//  FavoriteViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func getAllItems()
}

final class FavoriteViewModel: FavoriteViewModelProtocol {
    private let coreDataManager = CoreDataManager.shared
    internal var imageModel: [ImageModel]?
    
    internal func getAllItems() {
      let result = self.coreDataManager.getAllItems()
        switch result {
        case .success(let items):
            self.imageModel = items
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
