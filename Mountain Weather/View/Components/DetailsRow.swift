//
//  DetailsRow.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 21/08/2021.
//

import SwiftUI


struct SettingRow: View {
    var title:String
    var value:String
    
    init(title:String,value:String) {
        self.title = title
        self.value = value
    }

    var body: some View {
        HStack{
            Text("\(title)")
            Spacer()
            Text("\(value)")
            
        }
    }
}

