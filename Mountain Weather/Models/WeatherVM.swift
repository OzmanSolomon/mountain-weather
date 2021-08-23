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
    
    init(item:WeatherListModel,model:WeatherBaseModel) {
        self.day = item.dtTxt?.formatDate()  ?? "NA"
        detail =  DetailsVM(item: item,model: model)
        self.image = item.weather?.first?.icon ?? "NA"     
    }
}

