//
//  MainView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var characterViewModel = CharacterViewModel() // ViewModelを作成

    @State var path = NavigationPath()
    @State private var currentView: ViewType = .home // 初期ビューを Home に設定

    var body: some View {
        ZStack {
            HStack {
                switch currentView {
                case .chara:
                    CharaView(characterViewModel: characterViewModel) // ViewModel を渡す
                case .gacha:
                    GachaView(characterViewModel: characterViewModel) // ViewModel を渡す
                case .map:
                    MapView(characterViewModel: characterViewModel)
                case .home:
                    HomeView(characterViewModel: characterViewModel) 
                }
            }
            VStack {
                NaviBar(
                    charaFunc: {
                        currentView = .chara
                    },
                    homeFunc: {
                        currentView = .home
                    },
                    gachaFunc: {
                        currentView = .gacha
                    },
                    mapFunc: { 
                        currentView = .map
                    }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MainView()
}
