//
//  ContentView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum ViewType: Hashable {
    case map
    case chara
    case gacha
    case home
}

struct TopView: View {
    @StateObject private var characterViewModel = CharacterViewModel() // ViewModel を作成
    @State private var path = NavigationPath()
    @State private var currentView: ViewType = .home // 初期ビューを Home に設定

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    switch currentView {
                    case .chara:
                        CharaView(characterViewModel: characterViewModel)
                    case .gacha:
                        GachaView(characterViewModel: characterViewModel)
                    case .home:
                        HomeView(characterViewModel: characterViewModel)
                    case .map:
                        MapView(characterViewModel: characterViewModel) // 修正
                    }
                }
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
                .edgesIgnoringSafeArea(.all)
            }
            .navigationDestination(for: ViewType.self) { viewType in
                switch viewType {
                case .map:
                    MapView(characterViewModel: characterViewModel) // 修正
                case .chara:
                    CharaView(characterViewModel: characterViewModel)
                case .gacha:
                    GachaView(characterViewModel: characterViewModel)
                case .home:
                    HomeView(characterViewModel: characterViewModel)
                }
            }
        }
    }
}

#Preview {
    TopView()
}
