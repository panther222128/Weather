//
//  LocationWeathers.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

struct LocationWeathers {
    
    let locationWeathers: [LocationWeather]
    let title: String
}

struct LocationWeather {

    let id: Int
    let applicableDate: String
    let weatherStateName: String
    let weatherStateAbbreviation: String
    let windSpeed: Float
    let windDirection: Float
    let windDirectionCompass: String
    let created: String
    let minTemperature: Float
    let maxTemperature: Float
    let temperature: Float
    let airPressure: Float
    let humidity: Float
    let visibility: Float
    let predictability: Int

}
