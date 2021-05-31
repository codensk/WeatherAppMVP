//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 27.05.2021.
//

import Foundation
import CoreLocation

protocol WeatherView: AnyObject {
    func setLocation(_ location: String)
    func setWeekDay(_ weekDay: String)
    func setWeatherDescription(_ weatherDescription: String)
    func setTemperature(_ temperature: String)
    func setWeatherBackground(_ suffix: String)
    func setWeatherIcon(_ iconName: String)
}

class WeatherPresenter {
    
    // MARK: - Properties
    weak var view: WeatherView?
    weak var locationManager: LocationDataService?
    weak var weatherService: WeatherDataService?
    
    private var weatherLoadedData: (String)?
    
    // MARK: - Initializators
    init(with view: WeatherView, locationManager: LocationDataService, weatherService: WeatherDataService) {
        self.view = view
        self.locationManager = locationManager
        self.locationManager?.delegate = self
        self.locationManager?.determineCurrentLocation()
        
        self.weatherService = weatherService
        
    }
    
    // MARK: - Methods
    func loadWeatherData(lat: String, lon: String) {
        weatherService?.fetchWeather(lat: lat, lon: lon, completionHandler: { weather, response, error in
            guard let weather = weather, error == nil else {
                print("error")
                return
            }
            
            let weatherElement = weather.weather[0]
            let iconName = weatherElement.icon
            let locationName = weather.name
            let condition = weatherElement.weatherDescription
            let temperature = "\(Int(round(weather.main.temp)))"
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru")
            dateFormatter.dateFormat = "EEEE"
            
            let currentDate = dateFormatter.string(from: date)
            
            let suffix = String(iconName.suffix(1))
            
            DispatchQueue.main.async {
                self.view?.setLocation(locationName)
                self.view?.setTemperature(temperature)
                self.view?.setWeekDay(currentDate)
                self.view?.setWeatherDescription(condition)
                self.view?.setWeatherBackground(suffix)
                self.view?.setWeatherIcon(iconName)
            }
        })
    }
}

// MARK: - Extensions
extension WeatherPresenter: LocationDataServiceDelegate {
    func didUpdateLocations(_ coordinates: CLLocationCoordinate2D) {
        loadWeatherData(lat: String(coordinates.latitude), lon: String(coordinates.longitude))
    }
}
