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
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    private let coreDataManager = CoreDataManager.shared
    internal var requestLimi = 5
    internal var imageData: Data?
    internal var imageUrl: URL?
    
    internal func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?) {
     let result = await imageService.getImage(height: height, width: width, text: text)
        return result
    }
    
    internal func createItem() {
        guard let data = self.imageData,
              let url = self.imageUrl else { return }
        self.coreDataManager.createItem(data: data,imageUrl: url)
    }
    
}
