//
//  WeatherListPresenter.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import Foundation
import RealmSwift

protocol WeatherListPresenterProtocol {
    func WeatherListSuccessed(model:WeatherBaseModel,action: ()-> Void) 
    func WeatherListFaild(error:String)
    func gotLocalDataSuccessfully(localData:Results<weatherLocalModel>, action:() -> Void)
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
            return "\(temp)".changeCentigradeToFahrenheit() + " Fº"
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
    
    func WeatherListSuccessed(model:WeatherBaseModel,action: ()-> Void) {
        weatherBaseModel = model.list
        weatherBaseModel?.forEach({ item in
            weatherVMList.append(
                WeatherVM(item: item, model: model)
            )
        })
        store.state = .loaded(weatherVMList)
        action()
    }
    
    func gotLocalDataSuccessfully(localData:Results<weatherLocalModel>, action:() -> Void){
        var myModel = [WeatherVM]()
        localData.forEach { weatherLocalModel in
            var baseModel:WeatherBaseModel
            var listBaseModel:WeatherListModel
            (baseModel,listBaseModel) = weatherLocalModel.convertToBaseModel()    
            myModel.append(WeatherVM(item: listBaseModel, model: baseModel))
        }
        if myModel.count > 0 {
            store.state = .loaded(myModel)
        } else {
            store.state = .loading
        }
        action()
    }
}


