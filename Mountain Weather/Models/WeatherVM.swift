//
//  WeatherVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation

struct WeatherVM : Identifiable {
    var id = UUID()
    let day: String
    let detail:DetailsVM
    let image: String
    
}
