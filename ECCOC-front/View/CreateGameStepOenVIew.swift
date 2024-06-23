//
//  createGameStepOenVIew.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/21.
//

import SwiftUI
import MapKit

struct CreateGameStepOenVIew: View {
    @StateObject var gameViewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    let bounds = UIScreen.main.bounds;
    @State var inputName = ""
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                ZStack{
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 70)
                    VStack {
                        Text("STEP")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                        Text("1")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                    }
                }
                .padding([.bottom], 8)
                .padding([.top], 24)
                Text("今回の集合場所を設定しよう")
                    .fontWeight(.heavy)
                    .padding([.bottom], 32)
                
                HStack(spacing: 0){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("目的地を検索", text: $inputName)
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
                Map()
                    .border(.gray, width: 2)
                    .frame(width: bounds.width * 0.8, height: bounds.width * 0.8)
                Spacer()
            }
            .frame(height: bounds.height * 0.7)
            NavigationLink(destination: CreateGameStepTwoVIew(gameViewModel: gameViewModel)){
                Btn(text: "次へ", bgColor: "BtnColor")
            }
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
        
    }
}

#Preview {
    CreateGameStepOenVIew(gameViewModel: GameViewModel())
}
