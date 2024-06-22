//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Int{
    case root, gameCreateStep1, gameCreateStep2
    
    var toString: String{
        ["ホーム"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination() -> some View{
        switch self {
        case .root: MapView()
        case .gameCreateStep1: CreateGameStepOenVIew()
        case .gameCreateStep2: CreateGameStepTwoVIew()
        }
    }
}

