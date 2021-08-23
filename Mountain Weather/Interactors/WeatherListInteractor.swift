//
//  WeatherListInteractor.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//


import Foundation
import Alamofire
import RealmSwift

protocol WeatherListProtocol {
    func fetchWeather()
    func getLocalWeather() throws
    func saveLocalWeather(list:[WeatherListModel],model:WeatherBaseModel)throws
    
}

class WeatherListInteractor{
    private let apiManager = ApiManager()
    private let url:String
    private var data:Data?
    private let decoder = JSONDecoder()
    private let presentr : WeatherListPresenterProtocol
    init(presentr:WeatherListPresenterProtocol = WeatherListPresenter()) {
        self.presentr = presentr
        url = apiManager.baseUrl()
    }
    
}

extension WeatherListInteractor:WeatherListProtocol{
    func fetchWeather() {
        apiManager.getMethod(url: url , withSuccess: { (data,error,statusCode)   in
            if let weatherBaseModel = try? self.decoder.decode(WeatherBaseModel.self, from: data!){
                DispatchQueue.main.async {
                    self.presentr.WeatherListSuccessed(model: weatherBaseModel)
                }
                do {
                    if let list  = weatherBaseModel.list {
                        try  self.saveLocalWeather(list: list, model: weatherBaseModel)
                    }
                } catch {
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.presentr.WeatherListFaild(error: "NA")
                }
            }
        })
        { (error) in
            DispatchQueue.main.async {
                self.presentr.WeatherListFaild(error: error.localizedDescription)
            }
        }
    }
    
    func getLocalWeather() throws{
        do{
            let localData = try PersistenceManager().unpresistence(model:weatherLocalModel.self )
            presentr.gotLocalDataSuccessfully(localData: localData)
        } catch {
            print(error)
        }
    }
    
    func saveLocalWeather(list:[WeatherListModel],model:WeatherBaseModel)throws{
        var myModel = [weatherLocalModel]()
        do{
            try   PersistenceManager().cleanPresistenced(model: weatherLocalModel.self)
            
            list.forEach { item in
                let localItem = weatherLocalModel(item: item, model: model)
                myModel.append(localItem)
            }
            
            try   PersistenceManager().presistence(model: myModel)
        } catch {
            throw error
        }
    }
}
