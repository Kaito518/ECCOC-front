//
//  HomeView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/23.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject var gameViewModel = GameViewModel()
    @State private var TotalCoin = 1000
    
    var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let bounds = UIScreen.main.bounds
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
                // 背景画像を追加
                Image("haikei1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Image("maru")
                    .padding(.top, 325)
                
                Image("shadow")
                    .padding(.top, 350)
                
                Image("taiin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 390, height: 390) // ここで画像のサイズを大きくします
                    .padding(.top, -10)
                
                TotalCoins(TotalC: TotalCoin)
                    .padding(.top, -350)
                
                // Mail button as NavigationLink
                NavigationLink(destination: MailView().navigationBarBackButtonHidden(true)) {
                    Image("mailbutton")
                        .resizable()
                        .frame(width: 55, height: 55) // Adjust the size as needed
                }
                .padding(.top, -355)
                .offset(x: -155)
                
                Image("settingBtn")
                    .padding(.top, -355)
                    .offset(x: 155)
                
                if !gameViewModel.isPlay {
                    ZStack {
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 50.0,
                                bottomLeading: 50.0,
                                bottomTrailing: 0.0,
                                topTrailing: 0.0
                            ),
                            style: .continuous
                        )
                        .frame(width: 160, height: 55)
                        .foregroundStyle(.red)
                        .position(CGPoint(x: bounds.width - 80, y: bounds.height - 170))
                        
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 50.0,
                                bottomLeading: 50.0,
                                bottomTrailing: 0.0,
                                topTrailing: 0.0
                            ),
                            style: .continuous
                        )
                        .stroke(style: .init(lineWidth: 2, dash: [6, 3]))
                        .frame(width: 155, height: 45)
                        .foregroundColor(.white)
                        .position(CGPoint(x: bounds.width - 76.5, y: bounds.height - 170))
                        
                        NavigationLink("キャラ図鑑", destination: CreateGameStepOenVIew(gameViewModel: gameViewModel))
                            .bold()
                            .foregroundStyle(.white)
                            .position(CGPoint(x: bounds.width - 76.5, y: bounds.height - 170))
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .stroke(gameViewModel.isPlay ? .cyan : .clear, lineWidth: 16)
            )
            .ignoresSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .navigationDestination(for: Router.self, destination: { append in
                append.Destination()
                    .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}

#Preview {
    HomeView()
}
