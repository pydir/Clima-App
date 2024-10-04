//
//  WeatherModel.swift
//  Clima
//
//  Created by Oguz Mert Beyoglu on 4.10.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let city: String
    let temperature: Float
    
    var formattedTemperature: String {
        String(format:"%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust"
        case 741:
            return "cloud.fog"
        case 751:
            return "sun.max.fill"
        case 761:
            return "sun.dust.fill"
        case 771:
            return "smoke.fill"
        case 781:
            return "tornado.circle"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    init(conditionId: Int, city: String, temperature: Float) {
        self.conditionId = conditionId
        self.city = city
        self.temperature = temperature
    }
    
}
