//
//  GameDataManager.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2025/02/06.
//

import Foundation
import MapKit

class GameDataManager: ObservableObject {
    @Published var coins: [CustomPointAnnotation] = []
    @Published var showCoinPopup = false
    @Published var lastCollectedCoin: CustomPointAnnotation? = nil
    @Published var collectedCoinPosition: CGPoint? = nil  // ポップアップの表示位置

    /// **現在地とゴールの間にコインをランダム配置**
    func generateCoins(userLocation: CLLocationCoordinate2D, goalLocation: CLLocationCoordinate2D) {
        coins.removeAll()
        
        let numberOfCoins = 10
        var uniqueLocations = Set<CLLocationCoordinate2D>()

        for _ in 0..<numberOfCoins {
            let randomFactor = Double.random(in: 0.2...0.8) // 20%〜80% の範囲で配置
            let randomLat = userLocation.latitude + (goalLocation.latitude - userLocation.latitude) * randomFactor + Double.random(in: -0.001...0.001)
            let randomLon = userLocation.longitude + (goalLocation.longitude - userLocation.longitude) * randomFactor + Double.random(in: -0.001...0.001)

            let newLocation = CLLocationCoordinate2D(latitude: randomLat, longitude: randomLon)

            if uniqueLocations.insert(newLocation).inserted {  // 重複防止
                let annotation = CustomPointAnnotation(annotation: MKPointAnnotation())
                annotation.annotation.coordinate = newLocation
                annotation.annotation.title = "Coin"
                coins.append(annotation)
            }
        }
    }

    /// **コイン取得処理**
    func collectCoin(at coin: CustomPointAnnotation, screenPosition: CGPoint) {
        coins.removeAll { $0.id == coin.id }
        lastCollectedCoin = coin
        collectedCoinPosition = screenPosition
        showCoinPopup = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showCoinPopup = false
            self.lastCollectedCoin = nil
            self.collectedCoinPosition = nil
        }
    }
}
