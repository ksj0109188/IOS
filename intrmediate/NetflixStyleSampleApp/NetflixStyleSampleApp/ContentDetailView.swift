//
//  ContentDetailView.swift
//  NetflixStyleSampleApp
//
//  Created by 김성준 on 2022/04/14.
//

import SwiftUI

struct ContentDetailView: View {
    @State var item:Item?
    
    var body: some View {
        VStack{
            if let item = item {
                Image(uiImage: item.image).aspectRatio(contentMode: .fit)
                Text(item.description)
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
            }else{
                Color.white
            }
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item0 = Item(description: "Dummy_흥미진진", imageName: "poster0")
        ContentDetailView(item: item0)
    }
}
