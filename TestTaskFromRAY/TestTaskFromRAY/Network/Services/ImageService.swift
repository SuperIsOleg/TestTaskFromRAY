//
//  ImageService.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

protocol ImageServiceProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?)
}

struct ImageService: HTTPClient, ImageServiceProtocol {
    func getImage(height: CGFloat, width: CGFloat, text: String) async -> (Result<Data, RequestError>, url: URL?) {
        return await downlodRequest(requestApi: ImageEndpoint.getImage(height: height,
                                                                width: width,
                                                                text: text))
    }
    
}
