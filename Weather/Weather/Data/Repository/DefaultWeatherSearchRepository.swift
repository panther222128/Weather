//
//  FirstRepository.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

final class DefaultWeatherSearchRepository: WeatherRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchLocationSearchResult(with searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void) {
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
    
    func fetchLocationWeather(with woeid: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void) {
        let apiEndpoint = APIEndpoint.getLocationEndpoint(with: woeid)
        self.dataTransferService.request(with: apiEndpoint, dataType: LocationWeatherResponseDTOs.self) { result in
            switch result {
            case .success(let data):
                let convertedToDomain = data.convertToDomain()
                completion(.success(convertedToDomain))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
