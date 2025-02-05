//
//  LocationManager.swift.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2025/02/04.
//

//import Foundation
//import CoreLocation
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//    
//    @Published var userLocation: CLLocation? = nil
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func requestLocation() {
//        locationManager.requestLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            DispatchQueue.main.async {
//                self.userLocation = location
//            }
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}
