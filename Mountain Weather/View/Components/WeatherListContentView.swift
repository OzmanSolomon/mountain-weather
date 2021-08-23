//
//  WeatherListContentView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//


import SwiftUI


struct WeatherListContentView : View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var appBarHeight : CGFloat = 3.5
    @State private var orientation = UIDeviceOrientation.unknown
    let weatherList : [WeatherVM]
    var presenter:WeatherRowPresenterProtocol
    
    init( weatherList : [WeatherVM], presenter:WeatherRowPresenterProtocol = WeatherRowPresenterPresenter() ) {
        self.weatherList = weatherList
        self.presenter = presenter
        if UIDevice.current.orientation.isLandscape  {
            self.appBarHeight =  2.0
        }
    }
    
    var body: some View{
        AnimatedTopView(headView: setHead(), bodyView: setBody())
    }
    
}

extension WeatherListContentView{
    func setHead() -> AnyView{
        return   AnyView(
            VStack() {
                Text((weatherList.first?.detail.city) ?? "NA")
                    .font(.system(size: 35))
                    .fontWeight(.semibold)
                    .padding( 0.0)
                    .foregroundColor(.black)
                Text((weatherList.first?.detail.howItFeel) ?? "NA")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .fontWeight(.regular)
                    .padding(.bottom)
                Text(presenter.temp(temp: (weatherList.first?.detail.temp) ?? "NA"))
                    .font(.system(size: 45))
                    .fontWeight(.thin)
                    .foregroundColor(.black)
            }
        )
    }
    
    func setBody() -> AnyView {
        AnyView(
            VStack{
                HStack{
                    Text("Coming Days")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                VStack(spacing: 20){
                    ForEach(weatherList) { item in
                        NavigationLink(destination: DetailsScreen(model: item.detail)){
                            WeatherRow(weatherVM:item)
                        }
                        .overlay(Divider(), alignment: .bottom)
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top)
            }
            .padding()
            .background(Color.white)
        )
    }
    
}

#if DEBUG
struct WeatherListContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListContentView(weatherList: mockUpData())
    }
}
#endif
