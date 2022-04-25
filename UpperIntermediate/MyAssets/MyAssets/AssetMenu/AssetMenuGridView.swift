//
//  AssetMenuGridView.swift
//  MyAssets
//
//  Created by 김성준 on 2022/04/24.
//

import SwiftUI

struct AssetMenuGridView: View {
    let menuList : [[AssetMenu]] = [
        [.creditscore, .bankAccount, .investment, .loan],        [.insurance, .creditcard, .cash, .realEstate]
    ]
    var body: some View {
        VStack(spacing:20){
            ForEach(menuList, id: \.self){ row in
                HStack(spacing:10){
                    ForEach(row){ menu in
                        Button(""){
                            print("\(menu.title)버튼 Tapped")
                        }.buttonStyle(AssetMenuButtonStyle(menu: menu))
                    }
                }
            }
        }
    }
}

struct AssetMenuGridView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMenuGridView()
    }
}
