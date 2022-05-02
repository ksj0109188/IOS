//
//  AssetSummaryView.swift
//  MyAssets
//
//  Created by 김성준 on 2022/05/02.
//

import SwiftUI

struct AssetSummaryView: View {
    @EnvironmentObject var assetData: AssetSummaryData
    
    var assets:[Asset]{
        return assetData.asseets
    }
    var body: some View {
        VStack(spacing:20){
            ForEach(assets){ assets in
                AssetSectionView(assetSection: assets)
            }.background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
    }
}

struct AssetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AssetSummaryView()
            .environmentObject(AssetSummaryData())
            .background(Color.gray.opacity(0.2))
        
    }
}
