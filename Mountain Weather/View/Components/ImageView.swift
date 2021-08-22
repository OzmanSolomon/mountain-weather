//
//  ImageView.swift
//  Mountain Weather
//
//  Created by Osman Solomon on 19/08/2021.
//

import URLImage // Import the package module
import SwiftUI

struct ImageView: View {
    let imageURL: URL
    init(id:String) {
        imageURL = URL(string:ApiManager().iconUrl(id) ?? "NA")!
    }
    var body: some View {
        URLImage(imageURL) { image in
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
