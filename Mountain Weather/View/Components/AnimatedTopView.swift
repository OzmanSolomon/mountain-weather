//
//  AnimatedTopView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 23/08/2021.
//

import SwiftUI

struct AnimatedTopView: View {
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var appBarHeight : CGFloat = 3.5
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    var headView: AnyView
    var bodyView: AnyView
    
    init(headView: AnyView,bodyView: AnyView) {
        self.headView = headView
        self.bodyView = bodyView
        if UIDevice.current.orientation.isLandscape  {
            self.appBarHeight =  2.0
        }
    }
    
    var body: some View {
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
                                // head content
                                headView
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
                    // body content
                    bodyView
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


struct AnimatedTopView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTopView(headView: AnyView(Text("")), bodyView: AnyView(Text("")))
    }
}
