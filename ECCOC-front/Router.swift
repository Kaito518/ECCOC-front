//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Int {
    case root, chara, charaResult
    
    var toString: String {
        ["ホーム"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination(
        CharaName: String = " ",
        CharaExplanation: String = "",
        characterViewModel: CharacterViewModel // 追加
    ) -> some View {
        switch self {
        case .root:
            MapView(characterViewModel: characterViewModel) // 修正: ViewModel を渡す
        case .chara:
            CharaView(characterViewModel: characterViewModel) // 修正: ViewModel を渡す
        case .charaResult:
            GachaResultView(
                CharaName: CharaName,
                CharaExplanation: CharaExplanation,
                characterViewModel: characterViewModel // 修正: ViewModel を渡す
            )
        }
    }
}
