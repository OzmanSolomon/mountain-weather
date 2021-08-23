//
//  DetailsVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation

struct DetailsVM  {
    let temp  : String
    let windSpeed  : String
    let windDeg   : String
    let tempMin  : String
    let tempMax  : String
    let pressure  : String
    let howItFeel  : String
    let weatherDescription  : String
    let city  : String
    
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
