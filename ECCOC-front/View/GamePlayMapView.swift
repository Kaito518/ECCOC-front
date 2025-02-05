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
    var meetingLocation: CLLocationCoordinate2D
    var goalLocation: CLLocationCoordinate2D // 目的地も受け取るよう修正

    @StateObject private var locationManager = LocationManager()
    @State private var region: MKCoordinateRegion
    @State private var userLocation: CLLocationCoordinate2D?

    @State private var isStart = true
    @State private var hasMovedToUserLocation = false // 初回のみ現在地を中央に

    let bounds = UIScreen.main.bounds

    init(meetingLocation: CLLocationCoordinate2D, goalLocation: CLLocationCoordinate2D) {
        self.meetingLocation = meetingLocation
        self.goalLocation = goalLocation
        _region = State(initialValue: MKCoordinateRegion(
            center: meetingLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.026, longitudeDelta: 0.005)
        ))
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: createAnnotations()) { location in
                MapAnnotation(coordinate: location.annotation.coordinate) {
                    annotationView(for: location.annotation)
                        .onTapGesture {
                            if location.annotation.title ?? "" == "You" {
                                moveToCurrentLocation()
                            }
                        }
                }
            }
            .onAppear {
                locationManager.requestLocation()
                withAnimation(.linear(duration: 0.8)) {
                    isStart = true
                }
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                if let newLocation = newLocation {
                    userLocation = newLocation.coordinate
                    if !hasMovedToUserLocation {
                        region.center = newLocation.coordinate
                        hasMovedToUserLocation = true
                    }
                }
            }

            if isStart {
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
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }

    private func createAnnotations() -> [IdentifiablePointAnnotation] {
        var annotations = [IdentifiablePointAnnotation]()

        let meetingAnnotation = MKPointAnnotation()
        meetingAnnotation.coordinate = meetingLocation
        meetingAnnotation.title = "Meeting Point"
        annotations.append(IdentifiablePointAnnotation(annotation: meetingAnnotation))

        let goalAnnotation = MKPointAnnotation()
        goalAnnotation.coordinate = goalLocation
        goalAnnotation.title = "Goal"
        annotations.append(IdentifiablePointAnnotation(annotation: goalAnnotation))

        if let userLocation = userLocation {
            let userAnnotation = MKPointAnnotation()
            userAnnotation.coordinate = userLocation
            userAnnotation.title = "You"
            annotations.append(IdentifiablePointAnnotation(annotation: userAnnotation))
        }

        return annotations
    }

    private func annotationView(for annotation: MKPointAnnotation) -> some View {
        Group {
            if annotation.title == "Meeting Point" {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            } else if annotation.title == "Goal" {
                Image("goal") // ゴールアイコンをカスタム
                    .resizable()
                    .frame(width: 40, height: 40)
            } else if annotation.title == "You" {
                Image("icon3") // ユーザーの位置アイコン
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
    }

    private func moveToCurrentLocation() {
        if let userLocation = userLocation {
            region.center = userLocation
        }
    }
}

#Preview {
    GamePlayMapView(
        meetingLocation: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125),
        goalLocation: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917) // 新宿の座標
    )
}
