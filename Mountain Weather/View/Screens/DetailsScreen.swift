//
//  DetailsScreen.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI 

struct DetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var store = AppState.shared
    var model:DetailsVM
    
    var body: some View {
        List {
            #warning("move condition to presenter")
            Section(header: Text("Temperature")) {
                if store.unit == 0 {
                    SettingRow(title: "temp", value:"\(self.model.temp) Cº")
                    SettingRow(title: "temp Min", value: "\(self.model.tempMin) Cº")
                    SettingRow(title: "temp Max", value: "\(self.model.tempMax) Cº")
                }else {
                    Text("\(self.model.temp)".changeCentigradeToFahrenheit() + " Fº")
                    
                    SettingRow(title: "temp", value:"\(self.model.temp)".changeCentigradeToFahrenheit() + " Fº")
                    SettingRow(title: "temp Min", value: "\(self.model.tempMin)".changeCentigradeToFahrenheit() + " Fº")
                    SettingRow(title: "temp Max", value: "\(self.model.tempMax)".changeCentigradeToFahrenheit() + " Fº")
                }
                
            }
            Section(header: Text("Wind")) {
                SettingRow(title: "wind Speed", value: model.windSpeed)
                SettingRow(title: "wind Deg", value: model.windDeg)
                
            }
            Section(header: Text("Others")) {
                SettingRow(title: "pressure", value: model.pressure)
                SettingRow(title: "how It Feel", value: model.howItFeel)
                SettingRow(title: "weather Description", value: model.weatherDescription)
            }
            
        }
        .navigationBarTitle("Details")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(presentationMode: presentationMode))
    }
    
}


