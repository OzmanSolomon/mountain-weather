//
//  Weather.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI


struct WeatherRow : View {
    var weatherVM : WeatherVM
    var presenter:WeatherRowPresenterProtocol
    
    init(weatherVM:WeatherVM,presenter:WeatherRowPresenterProtocol = WeatherRowPresenterPresenter()) {
        self.presenter = presenter
        self.weatherVM = weatherVM
    }
    
    var body: some View{
        HStack(alignment: .top){
            Text(self.weatherVM.day)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding([.top, .leading])
                .foregroundColor(.black)
            Spacer(minLength: 0)
            ImageView(id: self.weatherVM.image)
                .frame(width: 60, height: 60)
            Spacer(minLength: 0)
            Text(presenter.temp(temp:self.weatherVM.detail.temp))
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .padding([.top, .trailing])
        }
    }
    
}
