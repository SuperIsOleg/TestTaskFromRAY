//
//  SearchViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol SearchViewModelProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?)
    func createImageModel()
    func updateImageModel(item: ImageModel, imageData: Data, imageUrl: URL)
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    private let coreDataManager = ImageCoreDataManager.shared
    private var imageModel: [ImageModel]?
    internal var requestLimi = 5
    internal var imageData: Data?
    internal var imageUrl: URL?
    
    private func getAllImages() {
        let result = self.coreDataManager.getAllImages()
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
    
    internal func createImageModel() {
        guard let data = self.imageData,
              let url = self.imageUrl else { return }
        self.getAllImages()
        
        if let imageModel = self.imageModel {
            if imageModel.count < 5 {
                self.coreDataManager.createImageModel(data: data, imageUrl: url)
            } else {
                guard let model = imageModel.first else { return }
                self.updateImageModel(item: model, imageData: data, imageUrl: url)
            }
        } else {
            self.coreDataManager.createImageModel(data: data, imageUrl: url)
        }
        
    }
    
    internal func updateImageModel(item: ImageModel, imageData: Data, imageUrl: URL) {
        self.coreDataManager.updateImageModel(item: item, imageData: imageData, imageUrl: imageUrl)
    }
    
}
