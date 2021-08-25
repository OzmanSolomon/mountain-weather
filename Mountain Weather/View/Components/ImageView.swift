//
//  ImageView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import URLImage
import SwiftUI

struct ImageView: View {
    let imageURL: URL
    
    init(id:String) {
        #warning("move url to presenter")
        imageURL = URL(string:ApiManager().iconUrl(id: id) ?? "NA")!
    }
    
    var body: some View {
        URLImage(imageURL) {
            // This view is displayed before download starts
            ActivityIndicatorView()
        }
        inProgress: { progress in
            // Display progress
            ActivityIndicatorView()
        } failure: { error, retry in
            // Display error and retry button
            Image("mountains")
                .resizable()
                .frame(width: 25, height: 25)
        } content:   { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(id: "01n")
    }
}
