//
//  DataTransferService.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

enum DataTransferServiceError: Error {
    case noResponse
    case parsingError(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferService {
    func request<T: Decodable>(with endpoint: Requestable, dataType: T.Type, completion: @escaping (Result<T, DataTransferServiceError>) -> Void)
}

protocol DataTransferServiceErrorResolver {
    func resolve(error: NetworkError) -> Error
}

final class DefaultDataTransferService: DataTransferService {
    
    private let networkService: NetworkService
    private let errorResolver: DataTransferServiceErrorResolver
    
    init(networkService: NetworkService, errorResolver: DataTransferServiceErrorResolver = DefaultDataTransferServiceErrorResolver()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
    
    func request<T: Decodable>(with endpoint: Requestable, dataType: T.Type, completion: @escaping (Result<T, DataTransferServiceError>) -> Void) {
        guard let url = endpoint.url() else { return }
        let urlRequest = URLRequest(url: url)
        return self.networkService.request(request: urlRequest) { result in
            switch result {
            case .success(let data):
                let result = self.decode(data: data, dataType: T.self)
                DispatchQueue.main.async { completion(result) }
            case .failure(let error):
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    private func decode<T: Decodable>(data: Data?, dataType: T.Type) -> Result<T, DataTransferServiceError> {
        do {
            let decoder = JSONDecoder()
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.parsingError(error))
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferServiceError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
    
}

final class DefaultDataTransferServiceErrorResolver: DataTransferServiceErrorResolver {
    
    init() {
        
    }
    
    func resolve(error: NetworkError) -> Error {
        return error
    }
    
}
