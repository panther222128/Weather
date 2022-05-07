//
//  SecondViewModel.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/06.
//

import Foundation

protocol LocationWeatherViewModel {
    var locationWeathersStorage: Observable<[LocationWeather]?> { get }
    var isError: Observable<Bool> { get }
    var error: Observable<Error?> { get }
    
    func didFetchLocationWeather(of woeid: Int)
}

final class DefaultLocationWeatherViewModel: LocationWeatherViewModel {
    
    private var woeid: Int
    let locationWeathersStorage: Observable<[LocationWeather]?>
    let isError: Observable<Bool>
    let error: Observable<Error?>
    
    private let locationWeatherUseCase: LocationWeatherUseCase
    
    init(woeid: Int, locationWeatherUseCase: LocationWeatherUseCase) {
        self.woeid = woeid
        self.locationWeatherUseCase = locationWeatherUseCase
        self.locationWeathersStorage = Observable(nil)
        self.isError = Observable(false)
        self.error = Observable(nil)
        self.didFetchLocationWeather(of: woeid)
    }
    
    private func fetchLocationWeathers(woeid: Int, completion: @escaping (Result<[LocationWeather], Error>) -> Void) {
        self.locationWeatherUseCase.excuteFetchWeather(with: woeid) { result in
            switch result {
            case .success(let data):
                self.locationWeathersStorage.value = data.locationWeathers
                completion(.success(data.locationWeathers))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func load(with woeid: Int) {
        self.fetchLocationWeathers(woeid: woeid) { result in
            switch result {
            case .success(let data):
                self.locationWeathersStorage.value = data
            case .failure(let error):
                print(error)
            }
        }
    }

    private func update(using woeid: Int) {
        self.load(with: self.woeid)
    }
    
    func didFetchLocationWeather(of woeid: Int) {
        self.update(using: self.woeid)
    }
    
}
