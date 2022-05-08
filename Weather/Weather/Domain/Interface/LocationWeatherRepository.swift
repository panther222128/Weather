//
//  LocationWeatherRepository.swift
//  Weather
//
//  Created by Jun Ho JANG on 2022/05/08.
//

import Foundation

protocol LocationWeatherRepository {
    func fetchLocationWeather(with woeid: Int, completion: @escaping (Result<LocationWeathers, Error>) -> Void)
}
