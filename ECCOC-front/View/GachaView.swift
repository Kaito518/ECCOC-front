//
//  GachaView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/18.
//

import SwiftUI


struct GachaView: View {
    // キャラクターリスト
    let characters = [
        ("スライム", "水から生まれたスライムちゃん。\nいつも空を見上げて過ごしてます\n\n触ったら◉ぬ"),
        ("コリパ", "コリパの説明"),
        ("Sキング", "Sキングの説明"),
        ("隊員", "隊員の説明"),
        ("たいちょ", "たいちょの説明"),
        ("くまさん", "くまさんの説明"),
        ("ぐまさん", "ぐまさんの説明"),
        ("囚人", "囚人の説明"),
        ("看守", "看守の説明"),
    ]
    
    @State private var GetCharaName = "スライム"
    @State private var CharaExplanation = "水から生まれたスライムちゃん。\nいつも空を見上げて過ごしてます\n\n触ったら◉ぬ"
    @State private var showingConfirmation = false
    @State private var buttonOpacity: Double = 1.0
    @State private var rotation: Double = 0
    @State private var offset: CGFloat = 75
    @State private var isDimmed = false
    @State private var Whiteout = false
    @State private var gacha = false
    @State private var Discharge: CGFloat = -200
    @State private var WhiteDivision: CGFloat = 4
    @State private var BlueDivision: CGFloat = -4
    @State private var WhiteOpened: CGFloat = 0
    @State private var BlueOpened: CGFloat = 0
    @State private var Open: CGFloat = 0
    @State private var Undo: CGFloat = 1
    @State private var character = false
    @State private var TotalCoin = 1000
    @State private var showingAlert = false
    @State private var path = NavigationPath()
    
    @ObservedObject var characterViewModel: CharacterViewModel
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.black.opacity(isDimmed ? 0.3 : 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .zIndex(2)
                
                VStack(spacing: 16) {
                    TotalCoins(TotalC: TotalCoin)
                    Text("新しいキャラを手に入れよう！")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    ZStack {
                        Image("gachagacha")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 450)
                        
                        Image("BlueCapsule")
                            .offset(x: 0, y: offset)
                        
                        Image("gachaFlame")
                            .offset(x: 0, y: 120)
                        
                        Image("Handle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 60)
                            .rotationEffect(.degrees(rotation), anchor: UnitPoint(x: 0.5, y: 0.5))
                            .offset(x: -2, y: 88)
                    }
                    
                    ZStack {
                        Button(action: {
                            showingConfirmation = true
                        }, label: {
                            VStack {
                                Text("ガチャを引く")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .offset(x: 0, y: 2)
                                
                                ZStack {
                                    Capsule()
                                        .fill(Color("GachaColor"))
                                        .frame(width: 100, height: 20)
                                        .offset(x: 0, y: -2)
                                    
                                    HStack(spacing: 30) {
                                        Image("coin")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 16)
                                        
                                        Text("1000")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12))
                                    }
                                    .offset(x: 0, y: -2)
                                }
                            }
                        })
                        .frame(width: 150, height: 55)
                        .background(Color("BtnColor"))
                        .cornerRadius(10)
                        .opacity(buttonOpacity)
                        .shadow(color: Color.black.opacity(0.25), radius: 2, x: 2, y: 2)
                    }
                }
                .offset(x: 0, y: 70)
                
                if showingConfirmation {
                    ZStack {
                        VStack(spacing: 34) {
                            Text("1000コイン消費して引きますか？")
                                .fontWeight(.bold)
                            HStack {
                                Button("いいえ") {
                                    showingConfirmation = false
                                }
                                .frame(width: 120, height: 40)
                                .background(Color("maincolor"))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 2, y: 2)
                                Button("はい") {
                                    if TotalCoin < 1000 {
                                        showingAlert = true
                                    } else {
                                        TotalCoin -= 1000
                                        
                                        showingConfirmation = false
                                        
                                        // ランダムなキャラクターを取得
                                        let randomCharacter = getRandomCharacter()
                                        GetCharaName = randomCharacter.name
                                        CharaExplanation = randomCharacter.explanation
                                        
                                        // アニメーション処理
                                        withAnimation(Animation.linear(duration: 0)) {
                                            buttonOpacity = 0.0
                                        }
                                        withAnimation(Animation.linear(duration: 2)) {
                                            rotation += 720
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation {
                                                offset = 170
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                                            withAnimation {
                                                isDimmed = true
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            withAnimation {
                                                gacha = true
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                            withAnimation {
                                                WhiteDivision = -65
                                                BlueDivision = 65
                                                WhiteOpened = 45
                                                BlueOpened = -45
                                                Open = -200
                                                Whiteout = true
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                                            character = true
                                            withAnimation(.easeInOut(duration: 2.0)) {
                                                Undo = 0
                                            }
                                        }
                                    }
                                }
                                .frame(width: 120, height: 40)
                                .background(Color("BtnColor"))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 2, y: 2)
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("エラー"), message: Text("コインが不足しています"), dismissButton: .default(Text("OK")))
                                }
                            }
                        }
                        .frame(width: 300, height: 200)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("BtnColor"), lineWidth: 10)
                        )
                    }
                    .offset(x: 0, y: 70)
                    .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
                }
                // 🔹 修正: 黒い背景を最背面に配置
                Color.black.opacity(isDimmed ? 0.5 : 0)
                    .ignoresSafeArea(edges: .all)

                // 🔹 修正: isDimmed が true のとき確実に画面全体を覆う
                if isDimmed {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                }

                // 🔹 修正: 白い背景 (Whiteout) も全体を覆うように
                if Whiteout {
                    Color.white.opacity(Undo)
                        .ignoresSafeArea()
                        .zIndex(100)
                }
                
                if gacha {
                    Image("charaGet")
                        .offset(x: 0, y: -110)
                    ZStack {
                        HStack {
                            Image("WhiteHalfCapsule")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 100)
                                .offset(x: WhiteDivision, y: Discharge)
                                .rotationEffect(.degrees(WhiteOpened))
                            Image("BlueHalfCapsule")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 100)
                                .offset(x: BlueDivision, y: Discharge)
                                .rotationEffect(.degrees(BlueOpened))
                        }
                        .onAppear {
                            withAnimation {
                                Discharge = 150 // カプセルの開く位置を調整
                                WhiteDivision = 70 // 横方向の開く位置を調整
                                BlueDivision = -70 // 横方向の開く位置を調整
                                WhiteOpened = 45 // 開く角度を調整
                                BlueOpened = -45 // 開く角度を調整
                            }
                        }
                    }
                    .offset(x: 0, y: Open)
                    .onAppear {
                        withAnimation {
                            Open = 20 // 縦方向の位置を調整
                        }
                    }
                }
                if character {
                    NavigationLink(value: Router.charaResult(CharaName: GetCharaName, CharaExplanation: CharaExplanation)) {
                        Image(GetCharaName)
                            .frame(width: 300, height: 300)
                            .offset(x: 0, y: 120)
                    }
                }
            }
            .ignoresSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Router.self) { route in
                switch route {
                case .root:
                    MapView(characterViewModel: characterViewModel)
                case .chara:
                    CharaView(characterViewModel: characterViewModel)
                case .charaResult(let name, let explanation): // ✅ 修正: 引数を受け取れる
                    GachaResultView(
                        CharaName: name,
                        CharaExplanation: explanation,
                        characterViewModel: characterViewModel
                    )
                }
            }
            
            // キャラ図鑑へのリンクを追加
            NavigationLink("キャラ図鑑", destination: CharacterCatalogView(characterViewModel: characterViewModel))
                .bold()
                .foregroundStyle(.white)
                .position(CGPoint(x: 300, y: 600)) // 座標は適宜調整してください
        }
    }
    
    // ランダムなキャラクターを取得する関数
    func getRandomCharacter() -> (name: String, explanation: String) {
        return characters.randomElement() ?? ("スライム", "水から生まれたスライムちゃん。\nいつも空を見上げて過ごしてます\n\n触ったら◉ぬ")
    }
}

#Preview {
    GachaView(characterViewModel: CharacterViewModel())
}
