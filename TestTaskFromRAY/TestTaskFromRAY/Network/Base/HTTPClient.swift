//
//  HTTPClient.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import Foundation

protocol HTTPClient {
    func request<T: ApiProtocol, U: Decodable>(decoder: JSONDecoder, requestApi: T, model: U.Type) async -> Result<U, RequestError>
}

extension HTTPClient {
    /**
     Complete Http request with parameters.
     - parameter T: api configuration of request including url, parameters, method, etc
     - parameter U: model to decode result of reponse
     */
    func request<T: ApiProtocol, U: Decodable>(
        decoder: JSONDecoder = JSONDecoder(),
        requestApi: T,
        model: U.Type) async -> Result<U, RequestError> {
            
            guard let url = URL(string: requestApi.baseURL) else {
                return .failure(.invalidURL)
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
                    return .failure(.noResponse)
                }
                switch response.statusCode {
                case (200...299):
                    guard let decodedResponse = try? decoder.decode(model, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                case (400...499):
                    return .failure(.message(message: "[\(response.statusCode)]  \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))"))
                case (500...599):
                    return .failure(.message(message: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))
                default:
                    return .failure(.message(message: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))
                }
            } catch {
                return .failure(.unknown)
            }
        }
}

