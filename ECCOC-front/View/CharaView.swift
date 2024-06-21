//
//  SettingView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

struct CharaView: View {
    var body: some View {
        Text("Chara!")
        NavigationLink(Router.root.toString, value: Router.root)
    }
}

#Preview {
    CharaView()
}
