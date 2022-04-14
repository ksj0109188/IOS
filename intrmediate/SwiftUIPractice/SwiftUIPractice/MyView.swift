//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 김성준 on 2022/04/14.
//

import SwiftUI

struct MyView: View {
    
    var body: some View {
        VStack{
            Text("Hello, World!")
            Text("만나서 반가워요")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
