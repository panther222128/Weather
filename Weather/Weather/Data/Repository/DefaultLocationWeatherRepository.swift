//
//  DefaultLocationWeatherRepository.swift
//  Weather
//
//  Created by Jun Ho JANG on 2022/05/08.
//

import Foundation

final class DefaultLocationWeatherRepository: LocationWeatherRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
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
