//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Int{
    case root, chara, charaResult
    
    var toString: String{
        ["ホーム"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination(CharaName:String?, CharaExplanation: String?) -> some View{
        switch self {
        case .root: MapView()
        case .chara: CharaView()
        case .charaResult: GachaResultView(CharaName: CharaName!, CharaExplanation: CharaExplanation!)
        }
    }
}

