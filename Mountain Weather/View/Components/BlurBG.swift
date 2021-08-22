//
//  BlurBG.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import SwiftUI

struct BlurBG : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        // for dark mode adoption...
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
        
    }
}
