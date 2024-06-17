//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Int{
    case root, setting
    
    var toString: String{
        ["ホーム", "設定"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination() -> some View{
        switch self {
        case .root: TopView()
        case .setting: CharaView()
        }
    }
}

