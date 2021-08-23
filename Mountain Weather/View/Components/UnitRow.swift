//
//  Unit.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI

struct UnitRow: View {
    @StateObject var store = AppState.shared
    
     var body: some View {
        HStack {
            Text("Unit")
            Spacer()
            HStack {
                Button(action: {
                    store.switchUnit(to: 0)
                }) {
                    Text("Cº")
                        .foregroundColor(store.unit == 0 ? .blue : .black)
                }
                Text(" / ")
                    .foregroundColor(.black)
                Button(action: {
                    store.switchUnit(to: 1)
                }) {
                    Text("Fº")
                        .foregroundColor(store.unit == 1 ? .blue : .black)
                }
            }
            .padding(.vertical,10)
            .clipShape(Capsule())
        }
    }
    
}

 
