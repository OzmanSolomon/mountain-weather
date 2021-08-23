//
//  weatherLocalModel.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import RealmSwift
@objc class weatherLocalModel: Object {
    @Persisted var id = UUID()
    @Persisted var day: String?
    @Persisted var detail:DetailsLocalModel?
    @Persisted var image: String?
    
    override init() {
        super.init()
    }
    
    convenience init(item:WeatherListModel,model:WeatherBaseModel) {
        self.init()
        self.day = item.dtTxt  ?? "NA"
        self.detail =  DetailsLocalModel(item: item,model: model)
        self.image = item.weather?.first?.icon ?? "NA"
    }
    
    func convertToBaseModel() -> (WeatherBaseModel,WeatherListModel){
        var listBaseModel = self.detail?.convertToListBaseModel() ?? WeatherListModel()
        listBaseModel.dtTxt = self.day
        let cityModel = City(name: self.detail?.city)
        let baseModel = WeatherBaseModel( city: cityModel)
        return (baseModel,listBaseModel)
    }
}


