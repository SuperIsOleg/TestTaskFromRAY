//
//  ImageEndpoint.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import Foundation

enum ImageEndpoint {
    case getImage(height: CGFloat, width: CGFloat, text: String)
}

extension ImageEndpoint: ApiProtocol {
    var path: String {
        switch self {
        case .getImage(let height, let width, let text):
            return "/\(height)x\(width)&text=\(text)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getImage:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getImage:
            return [:]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getImage:
            return nil
        }
    }
    
}
