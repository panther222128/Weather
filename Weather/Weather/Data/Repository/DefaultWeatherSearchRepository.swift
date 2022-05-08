//
//  FirstRepository.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

final class DefaultWeatherSearchRepository: WeatherSearchRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchWeatherSearchResult(with searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void) {
        let apiEndpoint = APIEndpoint.getSearchEndpoint(with: searchKeyword)
        self.dataTransferService.request(with: apiEndpoint, dataType: [LocationSearchResultResponseDTO].self) { result in
            switch result {
            case .success(let data):
                let convertedToDomain = data.map( { $0.convertToDomain() } )
                completion(.success(convertedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
