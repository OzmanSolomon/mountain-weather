//
//  TopView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI
struct TopView : View {
    var body: some View{
        
        HStack{
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(alignment: .top){
                    
                    Image("mountains")
                        .resizable()
                        .frame(width: 25, height: 30)
                    
                    Text("Mountain Weather")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                
                Text("One Month free, then $4.99/month.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .foregroundColor(.gray)
            }
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding([.leading, .bottom])
        .background(BlurBG())
    }
}

 
