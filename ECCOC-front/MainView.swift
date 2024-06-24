//
//  MainView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/23.
//

import SwiftUI


struct MainView: View {
    @State var path = NavigationPath()
    @State private var currentView: ViewType = .map

    var body: some View {
        ZStack{
            HStack {
                switch currentView {
                case .chara:
                    CharaView()
                case .gacha:
                    GachaView()
                default:
                    HomeView()
                }
            }
            VStack{
                NaviBar(
                    charaFunc: {
                        () -> Void in
                        currentView = .chara
                    },
                    homeFunc: {
                        () -> Void in
                        currentView = .map
                    },
                    gachaFunc: {
                        () -> Void in
                        currentView = .gacha
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

