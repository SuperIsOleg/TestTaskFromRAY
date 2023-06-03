//
//  SearchViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol SearchViewModelProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?)
    func createItem()
    func updateItem(item: ImageModel, imageData: Data, imageUrl: URL)
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    private let coreDataManager = CoreDataManager.shared
    private var imageModel: [ImageModel]?
    internal var requestLimi = 5
    internal var imageData: Data?
    internal var imageUrl: URL?
    
    private func getAllItems() {
        let result = self.coreDataManager.getAllItems()
        switch result {
        case .success(let items):
            self.imageModel = items
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    internal func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?) {
        let result = await imageService.getImage(height: height, width: width, text: text)
        return result
    }
    
    internal func createItem() {
        guard let data = self.imageData,
              let url = self.imageUrl else { return }
        self.getAllItems()
        
        if let imageModel = self.imageModel {
            if imageModel.count < 5 {
                self.coreDataManager.createItem(data: data,imageUrl: url)
            } else {
                let sortedArray = imageModel.sorted {
                    $0.createdAt < $1.createdAt
                }
                guard let model = sortedArray.first else { return }
                self.updateItem(item: model, imageData: data, imageUrl: url)
            }
        } else {
            self.coreDataManager.createItem(data: data,imageUrl: url)
        }
        
    }
    
    internal func updateItem(item: ImageModel, imageData: Data, imageUrl: URL) {
        self.coreDataManager.updateItem(item: item, imageData: imageData, imageUrl: imageUrl)
    }
    
}
