//
//  SearchViewModel.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol SearchViewModelProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<Data, RequestError>
}

final class SearchViewModel: SearchViewModelProtocol {
    private let imageService = ImageService()
    internal var requestLimi = 5
    
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<Data, RequestError> {
     let result = await imageService.getImage(height: height, width: width, text: text)
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}
