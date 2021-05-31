//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 27.05.2021.
//

import Foundation

class WeatherDataService {
    func fetchWeather(lat: String, lon: String, completionHandler: @escaping (_ weather: Weather?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=a68c98b4b3a026c0a1d4c9e9966ee828&units=metric&lang=ru"

        let task = URLSession.shared.dataTask(with: URL(string: url)!) { weather, response, error in
            guard let weather = weather, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            do {
                try JSONDecoder().decode(Weather.self, from: weather)
            } catch {
                print(error)
            }
           
            completionHandler(try? JSONDecoder().decode(Weather.self, from: weather), response, nil)
           
        }
        task.resume()
    }
}
