//
//  WeatherListLoadingView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import SwiftUI
import Shimmer


struct WeatherListLoadingView : View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var appBarHeight:CGFloat = 3.5
    var body: some View{
 
        HStack(alignment: .top, content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center){
                    GeometryReader{g in
                        ZStack(alignment: .topLeading){
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
                                Text("")
                                    .frame(width:180, height: 30)
                                    .background(Color.gray)
                                    .shimmering()
                                Text("")
                                    .frame(width:150, height: 20)
                                    .background(Color.gray)
                                    .padding(5)
                                    .shimmering()
                                Text("")
                                    .frame(width:60, height: 30)
                                    .background(Color.gray)
                                    .shimmering()
                                    .padding()
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
                    .frame(height: UIScreen.main.bounds.height / appBarHeight)
                   
                    VStack{
                        Spacer(minLength: 100)
                        HStack(alignment: .top){
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width:180, height: 20)
                                .background(Color.gray)
                            Spacer(minLength: 0)
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 20, height: 20)
                                .background(Color.gray)
                            
                            Spacer(minLength: 0)
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 80, height: 20)
                                .background(Color.gray)
                            
                        }
                        .padding()
                        .shimmering()
                        HStack(alignment: .top){
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width:180, height: 20)
                                .background(Color.gray)
                            Spacer(minLength: 0)
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 20, height: 20)
                                .background(Color.gray)
                            
                            Spacer(minLength: 0)
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 80, height: 20)
                                .background(Color.gray)
                            
                        }
                        .padding()
                        .shimmering()
                        HStack(alignment: .top){
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width:180, height: 20)
                                .background(Color.gray)
                            Spacer(minLength: 0)
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 20, height: 20)
                                .background(Color.gray)
                            
                            Spacer(minLength: 0)
                            
                            Text("")
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                                .frame(width: 80, height: 20)
                                .background(Color.gray)
                            
                        }
                        .padding()
                        .shimmering()
                        
                    }
                    .padding()
 
                }
            })
            
            if self.show{
                
                TopView()
            }
        })
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


#if DEBUG
struct WeatherListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListLoadingView()
    }
}
#endif
