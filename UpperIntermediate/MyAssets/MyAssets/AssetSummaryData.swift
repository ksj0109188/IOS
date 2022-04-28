//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 김성준 on 2022/04/25.
//

import SwiftUI

class AssetSummaryData: ObservableObject {
    @Published var asseets:[Asset] = load("assets.json")
}

func load<T:Decodable>(_ filename:String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension:nil) else {
        fatalError(filename + "을 찾지 못함")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch{
        fatalError(filename + "을 찾지 못함")
    }
    
    do{
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError(filename+"을 \(T.self)로 파싱할 수 없습니다.")
    }
}
