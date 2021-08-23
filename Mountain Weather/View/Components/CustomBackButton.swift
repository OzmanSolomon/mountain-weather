//
//  CustomBackButton.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 23/08/2021.
//

import SwiftUI

struct CustomBackButton: View {
    
    var presentationMode:Binding<PresentationMode>
    init(presentationMode:    Binding<PresentationMode>) {
        self.presentationMode = presentationMode
    }
    var body: some View {
        
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        })
        {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                Text("Back")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

