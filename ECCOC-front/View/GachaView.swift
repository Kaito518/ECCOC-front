//
//  GachaView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/18.
//

import SwiftUI

struct GachaView: View {
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
    @State private var TotalCoin = 100
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                TotalCoins(TotalC: TotalCoin)
                Text("新しいキャラを手に入れよう！")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                ZStack {
                    Image("gachagacha")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250,height: 450)
                    
                    Image("BlueCapsule")
                        .offset(x:0 ,y: offset)
                    
                    Image("gachaFlame")
                        .offset(x: 0,y: 120)
                    
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
                    },label: {
                        VStack {
                            Text("ガチャを引く")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .offset(x: 0,y: 2)
                            
                            ZStack {
                                Capsule()
                                    .fill(Color("GachaColor"))
                                    .frame(width:100, height: 20)
                                    .offset(x: 0,y: -2)
                                
                                HStack(spacing: 30) {
                                    Image("coin")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20,height: 16)
                                    
                                    Text("1000")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                }
                                .offset(x: 0,y: -2)
                            }
                        }
                    })
                    .frame(width: 150,height: 55)
                    .background(Color("BtnColor"))
                    .cornerRadius(10)
                    .opacity(buttonOpacity)
                    .shadow(color: Color.black.opacity(0.25), radius: 2, x: 2, y: 2)
                }
            }
            .offset(x: 0,y: -45)
            
            if showingConfirmation {
                ZStack {
                    VStack(spacing: 34) {
                        Text("1000コイン消費して引きますか？")
                            .fontWeight(.bold)
                        HStack {
                            Button("いいえ") {
                                showingConfirmation = false
                            }
                            .frame(width: 120,height: 40)
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
                                    
                                    // ガチャを開始するコードをここに移動
                                    withAnimation(Animation.linear(duration: 0)) {
                                        buttonOpacity = 0.0
                                    }
                                    withAnimation(Animation.linear(duration: 2)) {
                                        rotation += 720
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation{
                                            offset = 170
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                                        withAnimation{
                                            isDimmed = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation{
                                            gacha = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                        withAnimation{
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
                                        withAnimation(.easeInOut(duration: 2.0)){
                                            Undo = 0
                                        }
                                    }
                                }
                                
                            }
                            .frame(width: 120,height: 40)
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
                            .stroke(Color("BtnColor"),lineWidth: 10)
                    )
                }
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
            }
            if isDimmed {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
            }
            if Whiteout {
                Color.white.opacity(Undo)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(100)
            }
            if gacha {
                Image("charaGet")
                    .offset(x: 0,y: -250)
                ZStack {
                    HStack {
                        Image("WhiteHalfCapsule")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50,height: 100)
                            .offset(x: WhiteDivision,y: Discharge)
                            .rotationEffect(.degrees(WhiteOpened))
                        Image("BlueHalfCapsule")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50,height: 100)
                            .offset(x: BlueDivision,y: Discharge)
                            .rotationEffect(.degrees(BlueOpened))
                    }
                    .onAppear {
                        withAnimation {
                            Discharge = 80
                            WhiteDivision = 4
                            BlueDivision = -4
                            WhiteOpened = 0
                            BlueOpened = 0
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            gacha = false
                        }
                    }
                }
                .offset(x: 0, y: Open)
                .onAppear {
                    withAnimation {
                        Open = 0
                    }
                }
            }
            if character {
                Image("taityou")
                    .frame(width: 300,height: 300)
            }
        }
        
    }
}

#Preview {
    GachaView()
}
