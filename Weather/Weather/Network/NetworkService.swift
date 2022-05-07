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
    case noResult
    case notAllowed
    case server
    case unknown
    case generic(Error)
}

protocol NetworkService {
    func request(request: URLRequest, completion: @escaping ((Result<Data?, NetworkError>) -> Void))
}

final class DefaultNetworkService: NetworkService {
    
    func request(request: URLRequest, completion: @escaping ((Result<Data?, NetworkError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { data, response, requestError in
            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode
            switch statusCode {
            case 200..<300:
                guard let data = data else { return }
                completion(.success(data))
            case 300..<400:
                completion(.failure(.noResult))
            case 400..<500:
                completion(.failure(.notAllowed))
            case 500...:
                completion(.failure(.server))
            default:
                completion(.failure(.unknown))
            }
        }
        task.resume()
    }
    
}
