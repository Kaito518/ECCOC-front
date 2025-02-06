//
//  Router.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum Router: Hashable {
    case root
    case chara
    case charaResult(CharaName: String, CharaExplanation: String) // ✅ 引数を持たせる
    
    var toString: String {
        switch self {
        case .root:
            return "ホーム"
        case .chara:
            return "キャラ"
        case .charaResult(let CharaName, _): // ✅ キャラ名を表示する場合
            return CharaName
        }
    }
    
    @ViewBuilder
    func Destination(
        characterViewModel: CharacterViewModel // ✅ ViewModel のみ渡す
    ) -> some View {
        switch self {
        case .root:
            MapView(characterViewModel: characterViewModel)
        case .chara:
            CharaView(characterViewModel: characterViewModel)
        case .charaResult(let CharaName, let CharaExplanation): // ✅ 修正
            GachaResultView(
                CharaName: CharaName,
                CharaExplanation: CharaExplanation,
                characterViewModel: characterViewModel
            )
        }
    }
}
