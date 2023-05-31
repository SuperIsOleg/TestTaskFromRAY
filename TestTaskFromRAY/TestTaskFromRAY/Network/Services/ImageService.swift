//
//  ImageService.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol ImageServiceProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<ImageModel, RequestError>
}

struct ImageService: HTTPClient, ImageServiceProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> Result<ImageModel, RequestError> {
        return await request(decoder: JSONDecoder(),
                             requestApi: ImageEndpoint.getImage(height: height,
                                                                width: width,
                                                                text: text),
                             model: ImageModel.self)
    }
    
}
