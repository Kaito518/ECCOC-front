//
//  HomeView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/18.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    
    // `MapCameraPosition?` → `MapCameraPosition` に修正
    @State private var position: MapCameraPosition = .region(.init(
        center: .init(latitude: 35.681236, longitude: 139.767125),
        span: .init(latitudeDelta: 0.026, longitudeDelta: 0.005)
    ))

    var gameViewModel = false
    var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let bounds = UIScreen.main.bounds
    @State var path = NavigationPath()
    @State private var userInteracted = false
    
    init(characterViewModel: CharacterViewModel) { // イニシャライザを追加
            self.characterViewModel = characterViewModel
        }
    
    @ObservedObject var characterViewModel: CharacterViewModel

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                // `if let position = position` の不要なチェックを削除
                Map(position: $position) {
                    if let userLocation = locationManager.userLocation {
                        Annotation("", coordinate: userLocation.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    zoomToLocation(userLocation.coordinate)
                                }
                        }
                    }

                    if gameViewModel {
                        ForEach(Array(num.enumerated()), id: \.element) { index, _ in
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.682 + Double.random(in: -0.01...0.01), longitude: 139.766 + Double.random(in: -0.01...0.01))) {
                                Image(systemName: "bitcoinsign.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.white, .yellow)
                                    .cornerRadius(50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(.brown, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        zoomToLocation(CLLocationCoordinate2D(latitude: 35.682 + Double.random(in: -0.01...0.01), longitude: 139.766 + Double.random(in: -0.01...0.01)))
                                    }
                            }
                        }
                    }
                }

                if !gameViewModel {
                    ZStack {
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 50.0,
                                bottomLeading: 50.0,
                                bottomTrailing: 0.0,
                                topTrailing: 0.0
                            ),
                            style: .continuous
                        )
                        .frame(width: 160, height: 55)
                        .foregroundStyle(Color("BtnColor"))
                        .position(CGPoint(x: bounds.width - 80, y: bounds.height - 170))

                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: 50.0,
                                bottomLeading: 50.0,
                                bottomTrailing: 0.0,
                                topTrailing: 0.0
                            ),
                            style: .continuous
                        )
                        .stroke(style: .init(lineWidth: 2, dash: [6, 3]))
                        .frame(width: 155, height: 45)
                        .foregroundColor(.white)
                        .position(CGPoint(x: bounds.width - 76.5, y: bounds.height - 170))

                        NavigationLink("ゲーム作成", destination: CreateGameStepOenVIew())
                            .bold()
                            .foregroundStyle(.white)
                            .position(CGPoint(x: bounds.width - 76.5, y: bounds.height - 170))
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .stroke(gameViewModel ? .cyan : .clear, lineWidth: 16)
            )
            .ignoresSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .onAppear {
                locationManager.requestLocation()
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                guard let location = newLocation, !userInteracted else { return }
                position = .region(.init(
                    center: location.coordinate,
                    span: .init(latitudeDelta: 0.026, longitudeDelta: 0.005)
                ))
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        userInteracted = true
                    }
            )
        }
    }

    private func zoomToLocation(_ coordinate: CLLocationCoordinate2D) {
        let zoomedRegion = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )

        withAnimation {
            position = .region(zoomedRegion)
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var userLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.userLocation = location
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}

#Preview {
    MapView(characterViewModel: CharacterViewModel())
}
