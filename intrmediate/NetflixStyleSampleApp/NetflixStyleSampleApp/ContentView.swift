//
//  ContentView.swift
//  NetflixStyleSampleApp
//
//  Created by 김성준 on 2022/04/14.
//

import SwiftUI

struct ContentView: View {
    let titlees = ["Netflix Sample App"]
    var body: some View {
        NavigationView{
            List(titlees,id: \.self){
                let netflixVC = HomeViewControllerRepresentable().navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink($0, destination: netflixVC)
                
            }.navigationTitle("switfUI to UIKIT")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
