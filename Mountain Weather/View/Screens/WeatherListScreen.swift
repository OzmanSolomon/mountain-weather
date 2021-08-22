//
//  Weather.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI


struct WeatherListScreen : View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    var body: some View{
        NavigationView{
            switch store.state {
            case .loaded(let weatherList):
                WeatherListContentView(weatherList: weatherList)
                    .background(Color.white)
                     .navigationBarHidden(true)
            case .failed(let error):
                WeatherListErrorView(error: error)
                     .navigationBarHidden(true)
                    .background(Color.white)
             case .loading:
                WeatherListLoadingView()
                     .navigationBarHidden(true)
                    .background(Color.white)
             case .idle:
                WeatherListErrorView(error: "NA")
                     .navigationBarHidden(true)
                    .background(Color.white)
            }
            
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        
       
    }
    
}


#if DEBUG
struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListScreen()
        
    }
}
#endif
