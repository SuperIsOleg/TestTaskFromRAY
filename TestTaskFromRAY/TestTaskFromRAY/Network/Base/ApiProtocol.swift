//
//  ApiProtocol.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import Foundation

protocol ApiProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String : Any]? { get }
}

extension ApiProtocol {
    var baseURL: String {
        return NetworkConstants.url
    }
}
