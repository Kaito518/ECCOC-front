//
//  ContentView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/21.
//

import SwiftUI

extension Color {
    static let customGreen = Color(red: 102 / 255, green: 204 / 255, blue: 0 / 255)
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.customYellow.ignoresSafeArea()

                // 背景画像を追加
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Image("opening")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .frame(width: 330, height: 200)
                        .padding(.top, 255)

                    Spacer()

                    NavigationLink(destination: RegisterView(), label: {
                        Text("新規登録")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(Color.customGreen)
                            .cornerRadius(10.0)
                            .shadow(radius: 5.0)
                    })
                    .padding(.bottom, 16.9)

                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), label: {
                        Text("ログイン")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(Color.customRed)
                            .cornerRadius(10.0)
                            .shadow(radius: 5.0)
                    })
                    .padding(.bottom, 155)
                    
                    Image("shounin")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .frame(width: 220, height: 50)
                        .padding(.top, -130)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
