//
//  Weather.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 31.05.2021.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let weather: [WeatherElement]
    let main: Main
    let visibility: Int
   // let wind: Wind
    let clouds: Clouds
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed, deg: Int
//}
