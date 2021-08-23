//
//  WeatherRowPresenter.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 22/08/2021.
//

import Foundation
import RealmSwift

protocol WeatherRowPresenterProtocol {
    func temp(temp:String) ->String
}

class WeatherRowPresenterPresenter:WeatherRowPresenterProtocol{
    private let store = AppState.shared
    func temp(temp:String) ->String{
        if store.unit == 0 {
            return "\(temp) Cº"
        } else {
            return     "\(temp)".changeCentigradeToFahrenheit() + " Fº"
        }
    }
}
