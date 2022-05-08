//
//  LocationWeatherUseCase.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import Foundation

protocol LocationWeatherUseCase {
    func excuteFetchWeather(with woeid: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void)
}

final class DefaultLocationWeatherUseCase: LocationWeatherUseCase {
    
    private let locationWeatherRepository: LocationWeatherRepository
    
    init(locationWeatherRepository: LocationWeatherRepository) {
        self.locationWeatherRepository = locationWeatherRepository
    }
    
    func excuteFetchWeather(with woeid: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void) {
        self.locationWeatherRepository.fetchLocationWeather(with: woeid) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
