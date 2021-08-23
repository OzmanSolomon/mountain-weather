//
//  AppState.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI
import Combine

enum WeatherStateEnum:Equatable {
    case idle
    case loading
    case failed(String)
    case loaded([WeatherVM])
    
}

class AppState: ObservableObject{
    static let shared = AppState()
    @Published var unit = 0
    @Published var isNotificationsOn = false
    @Published var state = WeatherStateEnum.idle
    @Published var result: Result<WeatherVM, Error>?
    @Published private(set) var time = Date().timeIntervalSince1970
    private var cancellable: AnyCancellable?
    
    init() {
        self.unit = UserDefaults.standard.integer(forKey: "unit")
        isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    }

    func saveIsNotificationsOn(){
        UserDefaults.standard.set(self.isNotificationsOn, forKey: "isNotificationsOn")
    }
    
    func switchUnit(to unit:Int) {
        self.unit = unit
        UserDefaults.standard.set(self.unit, forKey: "unit")
      }

}

extension AppState{
    func start() {
          cancellable = Timer.publish(
              every: 1,
              on: .main,
              in: .default
          )
          .autoconnect()
          .sink { date in
              self.time = date.timeIntervalSince1970
          }
      }

      func stop() {
          cancellable = nil
      }
}
