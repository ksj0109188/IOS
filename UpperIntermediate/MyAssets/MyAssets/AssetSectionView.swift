//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by 김성준 on 2022/04/25.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    var body: some View {
        VStack(spacing:20){
            AssetSectionHeaderView(title: assetSection)
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0, type: .bankAccount, data: [
            AssetData(id: 0, title: "신한은행", amount: "53000000원"),
            AssetData(id: 0, title: "국민은행", amount: "150000000원"),
            AssetData(id: 0, title: "한꾹은행", amount: "200000000원")
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
