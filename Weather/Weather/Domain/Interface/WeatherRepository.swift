//
//  FirstRepository.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/04.
//

import Foundation

protocol WeatherRepository {
    func fetchLocationSearchResult(with searchKeyword: String, completion: @escaping (Result<[LocationSearchResult], Error>) -> Void)
    func fetchLocationWeather(with woeid: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void)
}
