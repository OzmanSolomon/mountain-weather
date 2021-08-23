//
//  Settings.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI
 
struct SettingsScreen: View {
    @StateObject var store = AppState.shared
    @Environment(\.presentationMode) var presentationMode
    private var interactor:SettingsInteractorProtocol
    init(interactor:SettingsInteractorProtocol = SettingsInteractor()) {
        self.interactor = interactor
    }
     private var btnBack : some View {
        Button(action: {
        self.presentationMode.wrappedValue.dismiss()
       }) {
           HStack {
            Image(systemName: "chevron.backward")
                   .aspectRatio(contentMode: .fit)
                   .foregroundColor(.black)
              Text("Back")
           }
           }
    .buttonStyle(PlainButtonStyle())
       }
    var body: some View {
          List {
            Section() {
                UnitRow()
                    .buttonStyle(BorderlessButtonStyle())
                Toggle("Local Notifications", isOn: $store.isNotificationsOn)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .onChange(of: $store.isNotificationsOn.wrappedValue, perform: { value in
                      store.saveIsNotificationsOn()
                        if value == true {
                            LocalNotificationManager().switchNotification(title:"title",subtitle:"subtitle")
                        }
                    })
            }
        }
     
          .navigationBarBackButtonHidden(true)
          .navigationViewStyle(StackNavigationViewStyle())
          .navigationBarTitle("Settings")
          .navigationBarItems(leading: btnBack)
    }
    
}


