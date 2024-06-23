//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Int{
    case root
    
    var toString: String{
        ["ホーム"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination() -> some View{
        switch self {
        case .root: MapView()
        }
    }
}

