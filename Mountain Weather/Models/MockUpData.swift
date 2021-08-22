//
//  MockUpData.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import Foundation

#if DEBUG

let mockUpData:[WeatherVM] = [
    WeatherVM(day: "NA",
              detail: DetailsVM(
                temp: "\(0.0)",
                windSpeed: "\(0.0)" ,
                windDeg: "\(0)",
                tempMin: "\(0.0)",
                tempMax: "\( 0.0)",
                pressure: "\(0)",
                howItFeel:  "NA",
                weatherDescription:   "NA",
                city:  "NA"),
              image:   "NA"),
    WeatherVM(day: "NA",
              detail: DetailsVM(
                temp: "\(0.0)",
                windSpeed: "\(0.0)" ,
                windDeg: "\(0)",
                tempMin: "\(0.0)",
                tempMax: "\( 0.0)",
                pressure: "\(0)",
                howItFeel:  "NA",
                weatherDescription:   "NA",
                city:  "NA"),
              image:   "NA"),
    WeatherVM(day: "NA",
              detail: DetailsVM(
                temp: "\(0.0)",
                windSpeed: "\(0.0)" ,
                windDeg: "\(0)",
                tempMin: "\(0.0)",
                tempMax: "\( 0.0)",
                pressure: "\(0)",
                howItFeel:  "NA",
                weatherDescription:   "NA",
                city:  "NA"),
              image:   "NA")
]


#endif
