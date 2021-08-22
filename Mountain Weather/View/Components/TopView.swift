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
                    
                    Image(systemName: "sun.dust.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25, height: 30)
                        // for dark mode adaption...
                        .foregroundColor(.primary)
                    
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
        // for non safe area phones padding will be 15...
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
//        .padding(.horizontal)
        .padding([.leading, .bottom])
        .background(BlurBG())
    }
}
