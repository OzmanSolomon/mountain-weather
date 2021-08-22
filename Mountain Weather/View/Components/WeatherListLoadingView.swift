//
//  WeatherListLoadingView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 20/08/2021.
//

import SwiftUI
 

struct WeatherListLoadingView : View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
   
    var body: some View{
 
        HStack(alignment: .top, content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center){
                    GeometryReader{g in
                        ZStack(alignment: .topLeading){
                            Image("cloud")
                                .resizable()
                         
                                NavigationLink(destination: SettingsScreen()) {
                                 
                                    Image(systemName: "gear")
                                           .aspectRatio(contentMode: .fit)
                                           .foregroundColor(.black)
                                      
                                 
                                   }
                                .padding(33)
                          
                            }
                                .frame(width: UIScreen.main.bounds.width,height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 3.5 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 3.5)
                            .onReceive(self.time) { (_) in
                            
                                // its not a timer...
                                // for tracking the image is scrolled out or not...
                                
                                let y = g.frame(in: .global).minY
                                
                                if -y > (UIScreen.main.bounds.height / 3.5) - 50{
                                    
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
                    .frame(height: UIScreen.main.bounds.height / 3.7)
                   
                    VStack{
                        Spacer(minLength: 100)
                        ActivityIndicatorView()
                    }
                    .padding()
 
                }
            })
            
            if self.show{
                
                TopView()
            }
        })
        .ignoresSafeArea( edges: .top)
         
        
}
    
}


#if DEBUG
struct WeatherListLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListLoadingView()
    }
}
#endif
