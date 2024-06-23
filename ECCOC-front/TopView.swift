//
//  ContentView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum ViewType {
    case map
    case chara
    case gacha
}

struct TopView: View {
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
                    MapView()
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
    TopView()
}
