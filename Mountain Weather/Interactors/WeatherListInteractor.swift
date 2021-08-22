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
    func getLocalWeather()
    func saveLocalWeather(list:[WeatherListModel],model:WeatherBaseModel)throws
   
}

class WeatherListInteractor{
    private let apiManager = ApiManager()
    private let url:String
    private var data:Data?
    private let decoder = JSONDecoder()
    private let presentr : WeatherListPresenterProtocol
    init() {
        presentr = WeatherListPresenter()
        url = apiManager.baseUrl()
    }
    
}

extension WeatherListInteractor:WeatherListProtocol{
    func fetchWeather() {
        apiManager.fetchFilms(url: url , withSuccess: { (data,error,statusCode)   in
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
    
    func getLocalWeather(){
         do{
            let localData =   try   PersistenceManager().unpresistence(model:weatherLocalModel.self )
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
                let localItem = weatherLocalModel()
                let detailsLocalModel = DetailsLocalModel()
                localItem.day = item.dtTxt?.formatDate()  ?? "NA"
                localItem.image =  item.weather?.first?.icon ?? "NA"
                detailsLocalModel.temp = "\(item.main?.temp ?? 0.0)"
                detailsLocalModel.windSpeed = "\(item.wind?.speed ?? 0.0)"
                detailsLocalModel.windDeg = "\(item.wind?.deg ?? 0)"
                detailsLocalModel.tempMin = "\(item.main?.tempMin ?? 0.0)"
                detailsLocalModel.tempMax = "\(item.main?.tempMax ?? 0.0)"
                detailsLocalModel.pressure = "\(item.main?.pressure ?? 0)"
                detailsLocalModel.howItFeel = item.weather?.first?.main?.rawValue ?? "NA"
                detailsLocalModel.weatherDescription = item.weather?.first?.weatherDescription?.rawValue
                detailsLocalModel.city = model.city?.name ?? "NA"
                
                localItem.detail = detailsLocalModel
                myModel.append(localItem)
            }
           
            try   PersistenceManager().presistence(model: myModel)
        } catch {
            throw error
        }
    }
    
  
}
