//
//  MockUpData.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import Foundation

#if DEBUG

func mockUpData()->[WeatherVM] {
    var element =  WeatherVM(item: WeatherListModel(), model: WeatherBaseModel())
    var elementDetail = DetailsVM(item: WeatherListModel(), model: WeatherBaseModel())
    
    elementDetail.city = "city"
    elementDetail.howItFeel = "howItFeel"
    elementDetail.pressure = "pressure"
    elementDetail.temp = "temp"
    elementDetail.tempMax = "tempMax"
    elementDetail.tempMin = "tempMin"
    elementDetail.weatherDescription = "weatherDescription"
    elementDetail.windDeg = "windDeg"
    elementDetail.windSpeed = "windSpeed"
    
    element.day = "day"
    element.image = "01"
    element.detail = elementDetail
    
    return [element,element,element]
}


#endif
