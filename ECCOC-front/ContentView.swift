//
//  ContentView.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2024/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: RegisterView()) {
                    Text("新規登録")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                        .shadow(radius: 10.0)
                }
                .padding()

                NavigationLink(destination: LoginView()) {
                    Text("ログイン")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 150)
                        .background(Color.green)
                        .cornerRadius(10.0)
                        .shadow(radius: 10.0)
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
