//
//  FirstUseCase.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

protocol WeatherSearchUseCase {
    func excuteSearch(with searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void)
}

final class DefaultWeatherSearchUseCase: WeatherSearchUseCase {
    
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func excuteSearch(with searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void) {
        self.weatherRepository.fetchLocationSearchResult(with: searchKeyword) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure((error)))
            }
        }
    }
    
}
