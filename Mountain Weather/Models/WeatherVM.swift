//
//  WeatherVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation

struct WeatherVM : Identifiable,Equatable {
    static func == (lhs: WeatherVM, rhs: WeatherVM) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var day: String
    var detail:DetailsVM
    var image: String
    
    init(item:WeatherListModel,model:WeatherBaseModel) {
        self.day = item.dtTxt?.formatDate()  ?? "NA"
        detail =  DetailsVM(item: item,model: model)
        self.image = item.weather?.first?.icon ?? "NA"     
    }
}

