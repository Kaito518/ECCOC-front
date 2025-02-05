//
//  SettingView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

struct CharaView: View {
    @ObservedObject var characterViewModel: CharacterViewModel // 追加

    var body: some View {
        VStack {
            Text("キャラ選択画面")
            Text("現在のキャラ: \(characterViewModel.selectedCharacterForHome ?? "未選択")")
        }
    }
}

#Preview {
    CharaView(characterViewModel: CharacterViewModel()) // 追加
}

