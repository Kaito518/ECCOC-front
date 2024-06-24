//
//  CreateGameStepThreeVIew.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/22.
//

import SwiftUI

struct Acount {
    var code = UUID()     // ユニークなIDを自動で設定
    var name : String
    var icon : String
    var isInvitation: Bool
}

struct CreateGameStepThreeVIew: View {
    @Environment(\.dismiss) var dismiss
    let bounds = UIScreen.main.bounds;
    @State var inputName = ""
    @State var isPopup = false
    @State private var acounts = [
        Acount(name: "ken", icon: "スライム", isInvitation: false),
        Acount(name: "higo", icon: "たいちょ", isInvitation: false),
        Acount(name: "kawakami", icon: "スライム", isInvitation: false),
        Acount(name: "koudai", icon: "隊員", isInvitation: false),
        Acount(name: "kawagishi", icon: "くまさん", isInvitation: false)
    ]
    @State var testBool = false;
    @State private var isActive = false
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                VStack(spacing: 0){
                    ZStack{
                        Circle()
                            .foregroundColor(.cyan)
                            .frame(width: 70)
                        VStack {
                            Text("STEP")
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            Text("3")
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding([.bottom], 8)
                    .padding([.top], 24)
                    Text("友達を招待しよう")
                        .fontWeight(.heavy)
                        .padding([.bottom], 32)
                    HStack(spacing: 0){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("友達を検索", text: $inputName)
                            .padding(5)
                            .cornerRadius(5)
                            .frame(width: bounds.width * 0.8)
                    }
                    .padding([.leading, .trailing], 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.primary.opacity(0.6), lineWidth: 0.3)
                    )
                    .padding([.bottom], 8)
                    ScrollView {
                        ForEach(0..<acounts.count, id: \.self) { index in
                            HStack{
                                Image(acounts[index].icon)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text(acounts[index].name)
                                    .font(.body)
                                Spacer()
                                Button(action: {
                                    acounts[index].isInvitation.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 80, height: 32)
                                            .foregroundColor(acounts[index].isInvitation ? .gray : .yellow)
                                        
                                        Text(acounts[index].isInvitation ? "招待済み": "招待する")
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                        
                                    }
                                })
                            }
                            .frame(width: bounds.width * 0.8)
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                        }
                        
                    }
                    Spacer()
                }
                .frame(height: bounds.height * 0.7)
                Button(action: {
                    isPopup = true
                }, label: {
                    Btn(text: "次へ", bgColor: "BtnColor")
                })
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .overlay(
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Image("returnBtn")
                    }
                )
                .position(CGPoint(x: 25, y: 10.0))
            )
            if isPopup {
                ZStack {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 32) {
                        VStack(spacing: 0){
                            Text("集合場所")
                                .fontWeight(.bold)
                                .padding([.bottom], 4)
                                .frame(width: 124)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.yellow),
                                    alignment: .bottom
                                )
                                .padding([.bottom], 8)
                            Text("東京駅")
                        }
                        VStack(spacing: 0){
                            Text("集合時間")
                                .fontWeight(.bold)
                                .padding([.bottom], 4)
                                .frame(width: 124)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.yellow),
                                    alignment: .bottom
                                )
                                .padding([.bottom], 8)
                            Text("20:00")
                        }
                        VStack(spacing: 0){
                            Text("開始時間")
                                .fontWeight(.bold)
                                .padding([.bottom], 4)
                                .frame(width: 124)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.yellow),
                                    alignment: .bottom
                                )
                                .padding([.bottom], 8)
                            Text("60分前")
                        }
                        Text("この設定でゲームを作成しますか？")
                            .fontWeight(.bold)
                        HStack(spacing: 16){
                            Btn(text: "いいえ", bgColor: "maincolor")
                                .onTapGesture {
                                    isPopup = false
                                }
                            Btn(text: "はい", bgColor: "BtnColor")
                                .onTapGesture {
                                    isActive = true
                                }
                            NavigationLink(destination: GamePlayMapView(), isActive: $isActive){
                                EmptyView()
                            }
                        }
                        
                    }
                    .frame(width: bounds.width * 0.7)
                    .padding()
                    .background(.white)
                    .padding(8)
                    .border(Color("BtnColor"), width: 8)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}

#Preview {
    CreateGameStepThreeVIew()
}
