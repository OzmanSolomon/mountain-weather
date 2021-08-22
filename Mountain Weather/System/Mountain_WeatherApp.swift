//
//  Mountain_WeatherApp.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI

@main
struct Mountain_WeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let interactor:WeatherListProtocol = WeatherListInteractor()
    init() {
        interactor.getLocalWeather()
        interactor.fetchWeather()
    }
    var body: some Scene {
        WindowGroup {
            WeatherListScreen() 
        }
    }
    
}
