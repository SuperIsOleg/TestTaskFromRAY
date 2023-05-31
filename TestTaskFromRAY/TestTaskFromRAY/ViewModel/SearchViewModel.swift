//
//  SearchViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol SearchViewModelProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<ImageModel, RequestError>
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<ImageModel, RequestError> {
     let result = await imageService.getImage(height: height, width: width, text: text)
        switch result {
        case .success(let model):
            return .success(model)
        case .failure(let error):
            return .failure(error)
        }
    }
}