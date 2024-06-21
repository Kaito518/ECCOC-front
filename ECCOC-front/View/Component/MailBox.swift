//
//  MailBox.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/20.
//

import SwiftUI

struct MailBox: View {
    @State private var showDropDown = false
    @State private var chevronChange = "chevron.forward"
    @State private var NewMali: CGFloat = 1
    @State private var NewMaliText: Font.Weight = .bold
    var userName: String
    
        private func MailCimponent() -> some View {
            
            return VStack(spacing: -1) {
                Button(action: {
                    chevronChange = showDropDown ? "chevron.forward" : "chevron.down"
                    withAnimation {
                        showDropDown.toggle()
                    }
                },label: {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            HStack{}
                                .frame(width: 6,height: 52)
                                .background(Color("BtnColor"))
                                .offset(x: -10,y: 0)
                                .opacity(NewMali)
                            
                            Text(userName+"さんから招待が届きました")
                                .frame(width: 300,height: 50)
                                .fontWeight(NewMaliText)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .offset(x: -30,y: 0)

                            Image(systemName: chevronChange)
                                .foregroundColor(.black)
                                .offset(x: -20,y: 0)
                        }
                        .frame(width: 350,height: 50)
                        
                        HStack{}
                            .frame(width: 340,height: 2)
                            .background(Color("underLine"))
                            .offset(x: 0,y: -1)
                            .zIndex(-1)
                    }
                })
                .onChange(of: showDropDown) { newValue in
                    if newValue {
                        NewMali = 0
                    }
                    if newValue && NewMaliText != .regular {
                        NewMaliText = .regular
                    }
                }
                if showDropDown {
                    VStack(spacing: 34) {
                        Text(userName+"さん\nからの招待を受け入れますか？")
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                        
                        HStack(spacing: 16) {
                            Btn(text: "いいえ",bgColor: "maincolor")
                            Btn(text: "はい",bgColor: "BtnColor")
                                .onTapGesture {
                                    print(userName+"さんのルームに入ります")
                                }
                        }
                    
                    }
                    .frame(width: 340,height: 200)
                    .background(Color("Mailbg"))
                    .zIndex(-100)
                }
            }
        }
    
    var body: some View {
        MailCimponent()
    }
}


#Preview {
    MailBox(userName: "こうだい")
}
