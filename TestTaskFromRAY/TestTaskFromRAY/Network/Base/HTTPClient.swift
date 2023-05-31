//
//  HTTPClient.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import Foundation

protocol HTTPClient {
    func downlodRequest<T: ApiProtocol>(requestApi: T) async -> (Result<Data, RequestError>, url: URL?)
}

extension HTTPClient {
    /**
     Complete Http request with parameters.
     - parameter T: api configuration of request including url, parameters, method, etc
     */

    func downlodRequest<T: ApiProtocol>(
        requestApi: T) async -> (Result<Data, RequestError>, url: URL?) {
            let urlPath = requestApi.baseURL + requestApi.path
            guard let url = URL(string: urlPath) else {
                return (.failure(.invalidURL), nil)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = requestApi.method.rawValue
            request.allHTTPHeaderFields = requestApi.headers
            
            if let body = requestApi.body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let response = response as? HTTPURLResponse else {
                    return (.failure(.noResponse), nil)
                }
                switch response.statusCode {
                case (200...299):
                    return (.success(data), response.url)
                case (400...499):
                    return (.failure(.message(message: "[\(response.statusCode)]  \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")), nil)
                case (500...599):
                    return (.failure(.message(message: "[\(response.statusCode)]  \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")), nil)
                default:
                    return (.failure(.message(message: HTTPURLResponse.localizedString(forStatusCode: response.statusCode))), nil)
                }
            } catch {
                return (.failure(.unknown), nil)
            }
        }
}

