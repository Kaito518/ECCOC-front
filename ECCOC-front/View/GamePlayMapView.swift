//
//  GamePlayMapView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct GamePlayMapView: View {
    var goalLocation: CLLocationCoordinate2D

    @StateObject private var locationManager = LocationManager()
    @StateObject private var gameData = GameDataManager()
    @EnvironmentObject var navigationController: NavigationController

    @State private var region: MKCoordinateRegion
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var isStart = true
    @State private var showGoalPopup = false
    @State private var collectedCoins = 0
    @State private var rankBonus = 0
    @State private var hasReachedGoal = false

    @State private var goalAnnotation: CustomPointAnnotation?
    @State private var userAnnotation: CustomPointAnnotation?

    let bounds = UIScreen.main.bounds

    init(goalLocation: CLLocationCoordinate2D) {
        self.goalLocation = goalLocation
        _region = State(initialValue: MKCoordinateRegion(
            center: goalLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.026, longitudeDelta: 0.005)
        ))
    }

    var body: some View {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: gameData.coins + createFixedAnnotations()) { location in
                    MapAnnotation(coordinate: location.annotation.coordinate) {
                        annotationView(for: location.annotation)
                    }
                }
                .onAppear {
                    locationManager.requestLocation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if let userLoc = locationManager.userLocation?.coordinate {
                            setupAnnotations(userLocation: userLoc) // 🔹 ここを追加
                            gameData.generateCoins(userLocation: userLoc, goalLocation: goalLocation)
                        }
                    }
                }
                .onChange(of: locationManager.userLocation) { newLocation in
                    if let newLocation = newLocation {
                        DispatchQueue.main.async {
                            userLocation = newLocation.coordinate
                            updateUserAnnotation()
                            updateCoinCollection()
                            checkGoalReached()
                        }
                    }
                }

                if gameData.showCoinPopup, let coin = gameData.lastCollectedCoin {
                    coinPopup(for: coin)
                }

                if isStart {
                    startAnimation()
                }

                if showGoalPopup {
                    goalPopup(isMultiplayer: false) // 🔹デフォルトはソロプレイ
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }

        /// 🔹 **初回のみユーザーアイコン & ゴールピンを作成**
        private func setupAnnotations(userLocation: CLLocationCoordinate2D) {
            if goalAnnotation == nil {
                goalAnnotation = CustomPointAnnotation(annotation: MKPointAnnotation())
                goalAnnotation?.annotation.coordinate = goalLocation
                goalAnnotation?.annotation.title = "Goal"
            }

            if userAnnotation == nil {
                userAnnotation = CustomPointAnnotation(annotation: MKPointAnnotation())
                userAnnotation?.annotation.coordinate = userLocation
                userAnnotation?.annotation.title = "You"
            }
        }

        /// 🔹 **現在地のアイコンを更新**
        private func updateUserAnnotation() {
            if let userLoc = userLocation {
                userAnnotation?.annotation.coordinate = userLoc
            }
        }

        /// 🔹 **ユーザーアイコン & ゴールのアノテーションを返す**
        private func createFixedAnnotations() -> [CustomPointAnnotation] {
            var annotations = [CustomPointAnnotation]()

            if let goalAnnotation = goalAnnotation {
                annotations.append(goalAnnotation)
            }

            if let userAnnotation = userAnnotation {
                annotations.append(userAnnotation)
            }

            return annotations
        }

        /// コイン取得処理
        private func updateCoinCollection() {
            if let userLocation = userLocation {
                for coin in gameData.coins {
                    let distance = calculateDistance(from: userLocation, to: coin.annotation.coordinate)
                    if distance < 10 {
                        DispatchQueue.main.async {
                            collectedCoins += 100
                            if let screenPosition = getScreenPosition(for: coin.annotation.coordinate) {
                                gameData.collectCoin(at: coin, screenPosition: screenPosition)
                            }
                        }
                    }
                }
            }
        }

        /// ゴール到達判定
        private func checkGoalReached() {
            if hasReachedGoal { return }

            if let userLocation = userLocation {
                let distance = calculateDistance(from: userLocation, to: goalLocation)
                if distance < 10 {
                    DispatchQueue.main.async {
                        hasReachedGoal = true
                        rankBonus = determineRankBonus()
                        showGoalPopup = true
                    }
                }
            }
        }
    
        /// 順位に応じたボーナスを決定
        private func determineRankBonus() -> Int {
            let rank = Int.random(in: 1...5)
            switch rank {
            case 1: return 100
            case 2: return 50
            case 3: return 30
            default: return 10
            }
        }
    
        /// 2地点間の距離を計算
        private func calculateDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
            let location1 = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let location2 = CLLocation(latitude: to.latitude, longitude: to.longitude)
            return location1.distance(from: location2)
        }

        /// コインの座標を画面座標に変換
        private func getScreenPosition(for coordinate: CLLocationCoordinate2D) -> CGPoint? {
            let mapSize = bounds.size
            let xRatio = (coordinate.longitude + 180) / 360
            let yRatio = 1 - ((coordinate.latitude + 90) / 180)

            return CGPoint(
                x: mapSize.width * CGFloat(xRatio),
                y: mapSize.height * CGFloat(yRatio) - 50
            )
        }
    
        /// コイン取得ポップアップ
        private func coinPopup(for coin: CustomPointAnnotation) -> some View {
            VStack {
                Image("coinget")
                    .resizable()
                    .frame(width: 200, height: 100)
                    .offset(y: -40)
            }
            .position(getScreenPosition(for: coin.annotation.coordinate) ?? CGPoint(x: bounds.width / 2, y: bounds.height / 2))
            .transition(.opacity)
        }

        /// ホームへ戻る処理
        private func goToHome() {
            DispatchQueue.main.async {
                navigationController.popToRoot() // 🔹 NavigationStack のルートに戻る
            }
        }

        /// ゴールポップアップ
        private func goalPopup(isMultiplayer: Bool) -> some View {
            VStack(spacing: 16) {
                Image(uiImage: UIImage(named: "goolpopapp") ?? UIImage())
                    .resizable()
                    .frame(width: 250, height: 60)

                VStack(spacing: 8) {
                    HStack {
                        Text("獲得したコイン")
                            .font(.headline)
                        Spacer()
                        Text("+\(collectedCoins)")
                            .font(.headline)
                    }

                    if isMultiplayer { // 対戦時のみ順位ボーナスを表示
                        HStack {
                            Text("順位ボーナス")
                                .font(.headline)
                            Spacer()
                            Text("+\(rankBonus)")
                                .font(.headline)
                        }
                        Divider()
                    }

                    HStack {
                        Text("合計")
                            .font(.title)
                            .bold()
                        Spacer()
                        Text("\(collectedCoins + (isMultiplayer ? rankBonus : 0)) コインゲット！")
                            .font(.title)
                            .bold()
                    }
                }
                .padding()
                .frame(width: 300)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "0096DE"), lineWidth: 6)
                )
                .cornerRadius(12)
                .shadow(radius: 5)

                // ホームに戻るボタン
                Button(action: {
                    goToHome()
                }) {
                    Text("ホームに戻る")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color(hex: "D65550"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
            }
            .frame(width: bounds.width, height: bounds.height)
            .background(Color.black.opacity(0.6))
            .onTapGesture {
                showGoalPopup = false
            }
        }

    /// スタート演出
    private func startAnimation() -> some View {
        VStack {
            Spacer()
            Image("start")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding()
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isStart = false
                }
            }
        }
    }

    /// マップ上のアイコン設定
    private func annotationView(for annotation: MKPointAnnotation) -> some View {
        Group {
            if annotation.title == "You" {
                Image("icon3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else if annotation.title == "Goal" {
                Image("gool")
                    .resizable()
                    .frame(width: 40, height: 40)
            } else if annotation.title == "Coin" {
                Image("coin1")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
}

#Preview {
    GamePlayMapView(
        goalLocation: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)
    )
}
