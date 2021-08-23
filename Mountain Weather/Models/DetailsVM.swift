//
//  DetailsVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation

struct DetailsVM  {
    var temp  : String
    var windSpeed  : String
    var windDeg   : String
    var tempMin  : String
    var tempMax  : String
    var pressure  : String
    var howItFeel  : String
    var weatherDescription  : String
    var city  : String
    
    init(item:WeatherListModel,model:WeatherBaseModel) {
        temp = "\(item.main?.temp ?? 0.0)"
        windSpeed = "\(item.wind?.speed ?? 0.0)"
        windDeg = "\(item.wind?.deg ?? 0)"
        tempMin = "\(item.main?.tempMin ?? 0.0)"
        tempMax = "\(item.main?.tempMax ?? 0.0)"
        pressure = "\(item.main?.pressure ?? 0)"
        howItFeel = item.weather?.first?.main?.rawValue ?? "NA"
        weatherDescription = item.weather?.first?.weatherDescription?.rawValue ?? "NA"
        city = model.city?.name ?? "NA"
    }
}
