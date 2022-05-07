//
//  LocationWeatherDTO.swift
//  Coordinator
//
//  Created by Jun Ho JANG on 2022/05/05.
//

import Foundation

struct LocationWeatherResponseDTOs: Decodable {
    
    let locationWeatherResponseDTOs: [LocationWeatherResponseDTO]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case locationWeatherResponseDTOs = "consolidated_weather"
    }

    func convertToDomain() -> LocationWeathers {
        let transformedToDomain = self.locationWeatherResponseDTOs.map( { $0.convertToDomain() } )
        return .init(locationWeathers: transformedToDomain, title: title)
    }
    
}

struct LocationWeatherResponseDTO: Decodable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case applicableDate = "applicable_date"
        case weatherStateName = "weather_state_name"
        case weatherStateAbbreviation = "weather_state_abbr"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case minTemperature = "min_temp"
        case maxTemperature = "max_temp"
        case temperature = "the_temp"
        case airPressure = "air_pressure"
        case humidity
        case visibility
        case predictability
    }
    
    func convertToDomain() -> LocationWeather {
        return .init(id: id, applicableDate: applicableDate, weatherStateName: weatherStateName, weatherStateAbbreviation: weatherStateAbbreviation, windSpeed: windSpeed, windDirection: windDirection, windDirectionCompass: windDirectionCompass, created: created, minTemperature: minTemperature, maxTemperature: maxTemperature, temperature: temperature, airPressure: airPressure, humidity: humidity, visibility: visibility, predictability: predictability)
    }
    
}
