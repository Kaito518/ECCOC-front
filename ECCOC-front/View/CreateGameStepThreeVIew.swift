//
//  CreateGameStepThreeVIew.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/22.
//

import SwiftUI
import CoreLocation

struct Acount {
    var code = UUID()
    var name: String
    var icon: String
    var isInvitation: Bool
}

struct CreateGameStepThreeVIew: View {
    @Environment(\.dismiss) var dismiss
    let bounds = UIScreen.main.bounds

    var meetingLocation: String = "未設定"
    var meetingTime: Date = Date()
    var startTime: Int = 0

    @State private var inputName = ""
    @State private var isPopup = false
    @State private var isActive = false
    @State private var goalCoordinate: CLLocationCoordinate2D?
    @State private var errorMessage: String?

    @State private var acounts = [
        Acount(name: "ken", icon: "スライム", isInvitation: false),
        Acount(name: "higo", icon: "たいちょ", isInvitation: false),
        Acount(name: "kawakami", icon: "スライム", isInvitation: false),
        Acount(name: "koudai", icon: "隊員", isInvitation: false),
        Acount(name: "kawagishi", icon: "くまさん", isInvitation: false)
    ]

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
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
                    .padding(.bottom, 8)
                    .padding(.top, 24)

                    Text("友達を招待しよう")
                        .fontWeight(.heavy)
                        .padding(.bottom, 32)

                    HStack(spacing: 0) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("友達を検索", text: $inputName)
                            .padding(5)
                            .cornerRadius(5)
                            .frame(width: bounds.width * 0.8)
                    }
                    .padding(.horizontal, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.primary.opacity(0.6), lineWidth: 0.3)
                    )
                    .padding(.bottom, 8)

                    ScrollView {
                        ForEach(0..<acounts.count, id: \.self) { index in
                            HStack {
                                Image(acounts[index].icon)
                                    .resizable()
                                    .frame(width: 50, height: 50)

                                Text(acounts[index].name)
                                    .font(.body)

                                Spacer()

                                Button(action: {
                                    acounts[index].isInvitation.toggle()
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 80, height: 32)
                                            .foregroundColor(acounts[index].isInvitation ? .gray : .yellow)

                                        Text(acounts[index].isInvitation ? "招待済み" : "招待する")
                                            .foregroundStyle(.white)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                                })
                            }
                            .frame(width: bounds.width * 0.8)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
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
                    geocodeMeetingLocation()
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

            if let errorMessage = errorMessage {
                errorPopup(message: errorMessage)
            }

            if isPopup {
                confirmationPopup()
            }
        }
    }

    /// **位置情報を取得**
    private func geocodeMeetingLocation() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(meetingLocation) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "住所を確認してください: \(meetingLocation)"
                }
            } else if let placemark = placemarks?.first,
                      let location = placemark.location {
                DispatchQueue.main.async {
                    self.goalCoordinate = location.coordinate
                    self.isPopup = true
                }
            }
        }
    }

    /// **エラーポップアップ**
    private func errorPopup(message: String) -> some View {
        VStack {
            Text("エラー")
                .font(.headline)
                .padding()
            Text(message)
                .font(.body)
                .padding()
            Button("閉じる") {
                self.errorMessage = nil
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(width: bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }

    /// **確認ポップアップ**
    private func confirmationPopup() -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    Text("集合場所")
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .frame(width: 124)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.yellow),
                            alignment: .bottom
                        )
                        .padding(.bottom, 8)
                    Text(meetingLocation)
                        .font(.title3)
                }
                VStack(spacing: 0) {
                    Text("集合時間")
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .frame(width: 124)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.yellow),
                            alignment: .bottom
                        )
                        .padding(.bottom, 8)
                    Text(formatDate(date: meetingTime))
                        .font(.title3)
                }
                VStack(spacing: 0) {
                    Text("開始時間")
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                        .frame(width: 124)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.yellow),
                            alignment: .bottom
                        )
                        .padding(.bottom, 8)
                    Text("\(startTime)分前")
                        .font(.title3)
                }
                Text("この設定でゲームを作成しますか？")
                    .fontWeight(.bold)
                    .font(.title3)

                HStack(spacing: 16) {
                    Btn(text: "いいえ", bgColor: "maincolor")
                        .onTapGesture {
                            isPopup = false
                        }
                    Btn(text: "はい", bgColor: "BtnColor")
                        .onTapGesture {
                            isActive = true
                        }
                    NavigationLink(
                        destination: GamePlayMapView(goalLocation: goalCoordinate ?? CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125)),
                        isActive: $isActive
                    ) {
                        EmptyView()
                    }
                }
            }
            .frame(width: bounds.width * 0.75)
            .padding()
            .background(.white)
            .padding(8)
            .border(Color("BtnColor"), width: 6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    CreateGameStepThreeVIew(meetingLocation: "東京駅", meetingTime: Date(), startTime: 10)
}

