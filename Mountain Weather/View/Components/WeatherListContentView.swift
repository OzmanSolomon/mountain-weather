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
 
        ZStack(alignment: .top, content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center){
                    GeometryReader{g in
                        ZStack{
                            Image("cloud")
                                .resizable()
                        VStack() {
                            HStack {
                                NavigationLink(destination: SettingsScreen()
                                                .background(Color.white)) {
                                 
                                    Image(systemName: "gear")
                                           .aspectRatio(contentMode: .fit)
                                           .foregroundColor(.black)
                                      
                                 
                                   }
                                .padding(.top,20)
                                .padding(23)
                                Spacer()
                          
                            } 
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
                        }
                            
                                .frame(width: UIScreen.main.bounds.width,height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / appBarHeight + g.frame(in: .global).minY  : UIScreen.main.bounds.height / appBarHeight)
                            .onReceive(self.time) { (_) in
                            
                                // its not a timer...
                                // for tracking the image is scrolled out or not...
                                
                                let y = g.frame(in: .global).minY
                                
                                if -y > (UIScreen.main.bounds.height / appBarHeight) - 50{
                                    
                                    withAnimation{
                                        
                                        self.show = true
                                    }
                                }
                                else{
                                    
                                    withAnimation{
                                        
                                        self.show = false
                                    }
                                }
                                
                      
                        }
                        
                    }
                   
                    // fixing default height...
                    .frame(height: UIScreen.main.bounds.height / appBarHeight+0.2)
                   
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
                    Spacer()
                    
                }
              
            })
            
            
            if self.show{
                
                TopView()
            }
        })
        .foregroundColor(.white)
        .ignoresSafeArea( edges: .top)
        .onRotate { newOrientation in
            orientation = newOrientation
            switch newOrientation {
            case .landscapeLeft , .landscapeRight:
                appBarHeight = 2.0
            case .unknown,.portrait,.portraitUpsideDown,.faceUp,.faceDown:
                appBarHeight = 3.5
            @unknown default:
                appBarHeight = 3.5
            }
        }

        
}
    
}


 
