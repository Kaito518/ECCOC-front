//
//  ContentView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

enum ViewType {
    case home
    case chara
    case gacha
}

struct TopView: View {
    @State var path = NavigationPath()
    @State private var currentView: ViewType = .home

    var body: some View {
        NavigationStack(path: $path) {
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
                GeometryReader{ proxy in
                    VStack{
                        NaviBar(
                            charaFunc: {
                                () -> Void in
                                currentView = .chara
                            },
                            homeFunc: {
                                () -> Void in
                                currentView = .home
                            },
                            gachaFunc: {
                                () -> Void in
                                currentView = .gacha
                            }
                        )
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Router.self, destination: { append in
                append.Destination()
                    .navigationTitle(append.toString)
                    .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}

#Preview {
    TopView()
}
