//
//  SearchViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol SearchViewModelProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<Data, RequestError>
    func createItem()
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    private let coreDataManager = CoreDataManager.shared
    internal var requestLimi = 5
    internal var imageData: Data?
    
   internal func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<Data, RequestError> {
     let result = await imageService.getImage(height: height, width: width, text: text)
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    internal func createItem() {
        guard let data = self.imageData else { return }
        self.coreDataManager.createItem(data: data)
    }
    
}
