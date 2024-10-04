//
//  weatherManager.swift
//  Clima
//
//  Created by Oguz Mert Beyoglu on 4.10.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    private static var apiKey = ""
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(apiKey)"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession  = URLSession(configuration: .default)
            let task        = urlSession.dataTask(with: url, completionHandler: {(data, response, error)  in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            })
            
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherStateId = data.weather[0].id
            let temperature = data.main.feels_like
            let city = data.name
            
            let weather = WeatherModel(conditionId: weatherStateId, city: city, temperature: temperature)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
