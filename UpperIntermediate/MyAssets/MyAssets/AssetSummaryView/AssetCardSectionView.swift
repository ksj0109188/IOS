//
//  AssetCardSectionView.swift
//  MyAssets
//
//  Created by 김성준 on 2022/05/08.
//

import SwiftUI

struct AssetCardSectionView: View {
    @State private var selectdTab = 1 //default value
    @ObservedObject var asset:Asset
    
    var assetData:[AssetData]{
        return asset.data
    }
    
    var body: some View {
        VStack{
            AssetSectionHeaderView(title: asset.type.title)
            TabMenuView(tabs: ["지난달 결제","이번달 결제","다음달 결제"], selectedTab: $selectdTab, updated: .constant(.nextMonth(amount: "10,000")))
            TabView(selection: $selectdTab, content: {
                ForEach(0...2, id: \.self){ i in
                    VStack{
                        ForEach(assetData){ data in
                            HStack{
                                Text(data.title)
                                    .font(.title)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(data.creditCardAmounts![i].amount)
                                    .font(.title2)
                                    .foregroundColor(.primary)
                            }
                            Divider()
                        }
                    }.tag(i)
                }
            }).tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct AssetCardSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = AssetSummaryData().asseets[5]
        AssetCardSectionView(asset: asset)
    }
}
