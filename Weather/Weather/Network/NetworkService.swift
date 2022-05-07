//
//  NetworkService.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
}

protocol NetworkService {
    func request(request: URLRequest, completion: @escaping ((Result<Data?, NetworkError>) -> Void))
}

final class DefaultNetworkService: NetworkService {
    
    func request(request: URLRequest, completion: @escaping ((Result<Data?, NetworkError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { data, response, requestError in
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                completion(.failure(error))
                
            } else {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
}
