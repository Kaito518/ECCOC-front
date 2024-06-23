//
//  SettingView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

struct CharaView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        Text("Chara!")
        NavigationLink(Router.root.toString, value: Router.root)
    }
}

#Preview {
    CharaView()
}
