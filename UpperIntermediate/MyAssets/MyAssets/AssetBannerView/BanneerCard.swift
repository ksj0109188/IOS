//
//  BanneerCard.swift
//  MyAssets
//
//  Created by 김성준 on 2022/04/24.
//

import SwiftUI

struct BanneerCard: View {
    var banner: AssetBanner
    
    var body: some View {
        Color(banner.backgroundColor)
            .overlay(VStack{
                Text(banner.title).font(.title)
                Text(banner.description).font(.subheadline)
        })
    }
}

struct BanneerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .red )
        BanneerCard(banner: banner0)
    }
}
