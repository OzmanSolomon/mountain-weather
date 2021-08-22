//
//  WeatherListPresenter.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation
import RealmSwift

protocol WeatherListPresenterProtocol {
    func WeatherListSuccessed(model:WeatherBaseModel)
    func WeatherListFaild(error:String)
    func gotLocalDataSuccessfully(localData:Results<weatherLocalModel>)
    func temp(temp:String) ->String
}

class WeatherListPresenter{
    private let store = AppState.shared
    private var weatherBaseModel:[(WeatherListModel)]?
    private var weatherVMList:[WeatherVM]
    init() {
        store.state = .loading
        weatherVMList = [WeatherVM]()
    }
    
}

extension WeatherListPresenter{
    func temp(temp:String) ->String{
        if store.unit == 0 {
            return "\(temp) Cº"
        } else {
            return     "\(temp)".changeCentigradeToFahrenheit() + " Fº"
        }
    }

}

extension WeatherListPresenter:WeatherListPresenterProtocol{
    func WeatherListFaild(error:String) {
        switch store.state {
        case .loading,.idle:
            store.state = .failed(error)
        default:
            break
        }
        
    }
    
    func WeatherListSuccessed(model:WeatherBaseModel) {
        weatherBaseModel = model.list
        weatherBaseModel?.forEach({ item in
            weatherVMList.append(
                WeatherVM(day:item.dtTxt?.formatDate()  ?? "NA",
                          detail: DetailsVM(
                            temp: "\(item.main?.temp ?? 0.0)",
                            windSpeed: "\(item.wind?.speed ?? 0.0)" ,
                            windDeg: "\(item.wind?.deg ?? 0)",
                            tempMin: "\(item.main?.tempMin ?? 0.0)",
                            tempMax: "\(item.main?.tempMax ?? 0.0)",
                            pressure: "\(item.main?.pressure ?? 0)",
                            howItFeel: item.weather?.first?.main?.rawValue ?? "NA",
                            weatherDescription: item.weather?.first?.weatherDescription?.rawValue ?? "NA",
                            city: model.city?.name ?? "NA"),
                          image: item.weather?.first?.icon ?? "NA")
            )
        })
        store.state = .loaded(weatherVMList)
    }
    
    func gotLocalDataSuccessfully(localData:Results<weatherLocalModel>){
        var myModel = [WeatherVM]()
        localData.forEach { weatherLocalModel in
            myModel.append(WeatherVM(
                            day: weatherLocalModel.day ?? "NA",
                            detail: DetailsVM(
                                temp:  weatherLocalModel.detail?.temp ?? "NA",
                                windSpeed: weatherLocalModel.detail?.windSpeed ?? "NA",
                                windDeg: weatherLocalModel.detail?.windDeg ?? "NA",
                                tempMin: weatherLocalModel.detail?.tempMin ?? "NA",
                                tempMax: weatherLocalModel.detail?.tempMax ?? "NA",
                                pressure: weatherLocalModel.detail?.pressure ?? "NA",
                                howItFeel: weatherLocalModel.detail?.howItFeel ?? "NA",
                                weatherDescription: weatherLocalModel.detail?.description ?? "NA",
                                city: weatherLocalModel.detail?.city ?? "NA"),
                            image: weatherLocalModel.image ?? "NA"))
        }
        store.state = .loaded(myModel)
    }
}


