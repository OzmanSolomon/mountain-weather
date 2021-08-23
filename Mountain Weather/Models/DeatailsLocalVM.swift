//
//  DeatailsLocalVM.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import Foundation
import RealmSwift

@objc class DetailsLocalModel: Object {
    @Persisted var temp: String
    @Persisted var windSpeed  : String?
    @Persisted var windDeg   : String?
    @Persisted var tempMin  : String?
    @Persisted var tempMax  : String?
    @Persisted var pressure  : String?
    @Persisted var howItFeel  : String?
    @Persisted var weatherDescription  : String?
    @Persisted var city  : String?
    
    override init() {
        super.init()
    }
    convenience init(item:WeatherListModel,model:WeatherBaseModel) {
        self.init()
        self.temp = "\(item.main?.temp ?? 0.0)"
        self.windSpeed = "\(item.wind?.speed ?? 0.0)"
        self.windDeg = "\(item.wind?.deg ?? 0)"
        self.tempMin = "\(item.main?.tempMin ?? 0.0)"
        self.tempMax = "\(item.main?.tempMax ?? 0.0)"
        self.pressure = "\(item.main?.pressure ?? 0)"
        self.howItFeel = item.weather?.first?.main?.rawValue ?? "NA"
        self.weatherDescription = item.weather?.first?.weatherDescription?.rawValue ?? "NA"
        self.city = model.city?.name ?? "NA"
        
    }
    
    func convertToListBaseModel() -> WeatherListModel {
        let listBaseModel = WeatherListModel( main: MainClass(
            temp:Double(self.temp),
            tempMin:Double(self.tempMin ?? "0.0"),
            tempMax:Double(self.tempMax ?? "0.0"),
            pressure:Int(self.pressure ?? "0")
        ),
        weather: [Weather(
                    main:setHowItFeel(),
                    weatherDescription:  setDescription())],
        wind: Wind(
            speed: Double(self.windSpeed ?? "0.0"),
            deg: Int(self.windDeg ?? "0")),
        dtTxt: "NA")
        return listBaseModel
    }
    
    func setHowItFeel()->MainEnum{
        var howIts : MainEnum
        switch self.howItFeel {
        case "Clear":
            howIts = .clear
        case "Clouds":
            howIts = .clouds
        case "Rain":
            howIts = .rain
        default:
            howIts = .clear
        }
        return howIts
    }
    
    func setDescription() ->Description{
        var description:Description
        
        switch self.weatherDescription {
        case "broken clouds":
            description = .brokenClouds
        case "clear sky":
            description = .clearSky
        case "few clouds":
            description = .fewClouds
        case "light rain":
            description = .lightRain
        case "overcast clouds":
            description = .overcastClouds
        case "scattered clouds":
            description = .scatteredClouds
        default:
            description = .brokenClouds
        }
        
        return description
    }
}
