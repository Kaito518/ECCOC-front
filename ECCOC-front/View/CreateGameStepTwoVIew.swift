//
//  CreateGameStepTwoVIew.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/22.
//

import SwiftUI

struct CreateGameStepTwoVIew: View {
    @Environment(\.dismiss) var dismiss
    let bounds = UIScreen.main.bounds
    
    @State var inputName = ""
    @State private var date = Date()
    @State var selectedIndex: Int = 10  // 初期値を設定
    @State private var isChecked = true
    
    var meetingLocation: String  // Passed from Step 1
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 70)
                    VStack {
                        Text("STEP")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                        Text("2")
                            .fontWeight(.heavy)
                            .foregroundStyle(.white)
                    }
                }
                .padding([.bottom], 8)
                .padding([.top], 24)
                
                Text("時間を設定しよう")
                    .fontWeight(.heavy)
                    .padding([.bottom], 32)
                
                VStack(spacing: 8) {
                    DatePicker("集合日時", selection: $date)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    HStack {
                        Text("開始時間")
                        Spacer()
                        Picker("開始時間", selection: $selectedIndex) {
                            Text("10分前").tag(10)
                            Text("30分前").tag(30)
                            Text("1時間前").tag(60)
                        }
                        .accentColor(.black)
                    }
                }
                .frame(width: bounds.width * 0.8)
                .padding(8)
                .overlay(
                    Rectangle()
                        .stroke(Color.primary.opacity(0.6), lineWidth: 0.3)
                )
                .border(.gray)
                .padding([.bottom], 32)
                
                VStack(spacing: 8) {
                    HStack {
                        Toggle(isOn: $isChecked) {
                            Text("通知")
                        }.toggleStyle(.switch)
                    }
                }
                .frame(width: bounds.width * 0.8)
                .padding(8)
                .overlay(
                    Rectangle()
                        .stroke(Color.primary.opacity(0.6), lineWidth: 0.3)
                )
                .border(.gray)
                
                Spacer()
            }
            .frame(height: bounds.height * 0.7)
            
            // Pass the selected data to the next view
            NavigationLink(destination: CreateGameStepThreeVIew(meetingLocation: meetingLocation, meetingTime: date, startTime: selectedIndex)) {
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
        .onAppear {
            // 無効な値を防ぐためのデフォルト値設定
            if selectedIndex != 10 && selectedIndex != 30 && selectedIndex != 60 {
                selectedIndex = 10
            }
        }
    }
}

#Preview {
    CreateGameStepTwoVIew(meetingLocation: "東京駅")
}
