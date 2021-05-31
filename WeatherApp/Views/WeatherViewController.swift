//
//  ViewController.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 27.05.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    // MARK: - Properties
    var locationService = LocationDataService()
    var weatherService = WeatherDataService()
    var weatherPresenter: WeatherPresenter?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherPresenter = WeatherPresenter(with: self, locationManager: locationService, weatherService: weatherService)
        
    }
    
    // MARK: - Methods
    private func getBackgroundLayer(from top: String, to bottom: String) -> CALayer {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(named: top)!.cgColor, UIColor(named: bottom)!.cgColor]
        layer.frame = view.bounds
        
        return layer
    }
    
    private func setBackgroundGradinet(for timeDay: TimeDay) {
        var gradientLayer: CALayer!
        
        switch timeDay {
        case .day:
            gradientLayer = getBackgroundLayer(from: "dayGradientStart", to: "dayGradientEnd")
        case .night:
            gradientLayer = getBackgroundLayer(from: "nightGradientStart", to: "nightGradientEnd")
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - Extensions
extension WeatherViewController: WeatherView {
    func setWeatherIcon(_ iconName: String) {
        weatherImage.image = UIImage(named: iconName)
    }
    
    func setLocation(_ location: String) {
        locationNameLabel.text = location
    }
    
    func setWeekDay(_ weekDay: String) {
        weekDayLabel.text = weekDay
    }
    
    func setWeatherDescription(_ weatherDescription: String) {
        weatherDescriptionLabel.text = weatherDescription
    }
    
    func setTemperature(_ temperature: String) {
        temperatureLabel.text = temperature
    }
    
    func setWeatherBackground(_ suffix: String) {
        if suffix == "n" {
            setBackgroundGradinet(for: .night)
        } else {
            setBackgroundGradinet(for: .day)
        }
    }
}
