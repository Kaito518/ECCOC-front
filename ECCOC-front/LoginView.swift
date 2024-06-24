//
//  LoginView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/22.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showAlert: Bool = false

    let apiService = APIService()

    var body: some View {
        ZStack {
            Color.customYellow.ignoresSafeArea()
            
            // 背景画像を追加
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -5, y: 10)
            
            VStack {
                // 登録フォーム
                VStack(alignment: .center, spacing: 40) {
                    HStack {
                        Spacer()
                        Text("おかえりなさい!")
                            .font(.system(size: 20))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .offset(y: -85)
                        Spacer()
                    }

                    TextField("メールアドレス", text: $email)
                        .padding()
                        .background(Color.white)
                        .frame(width: 220, height: 30)
                        .cornerRadius(1.0)
                        .shadow(radius: 1.0)
                        .offset(y: -77)

                    SecureField("パスワード", text: $password)
                        .padding()
                        .background(Color.white)
                        .frame(width: 220, height: 30)
                        .cornerRadius(1.0)
                        .shadow(radius: 1.0)
                        .offset(y: -85)

                    Button(action: {
                        isLoginSuccessful = true
                    }) {
                        Text("ログイン")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(Color.customRed)
                            .cornerRadius(10.0)
                            .shadow(radius: 5.0)
                            .offset(y: -15)
                    }
                }
                .padding(.top, 140)
                .padding(.bottom, 35)
                .background(Color.white)
                .cornerRadius(20.0)
                .shadow(radius: 20.0)
                .frame(width: 310) // 幅と高さを調整
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Login failed"), dismissButton: .default(Text("OK")))
            }
            
            NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $isLoginSuccessful) {
                EmptyView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
