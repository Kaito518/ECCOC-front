//
//  createGameStepOenVIew.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/21.
//

import SwiftUI
import MapKit

struct CreateGameStepOenVIew: View {
    @Environment(\.dismiss) var dismiss
    let bounds = UIScreen.main.bounds

    @State var inputName = ""  // 検索テキスト
    @State private var region = MKCoordinateRegion(
        center: .init(latitude: 35.681236, longitude: 139.767125),
        span: .init(latitudeDelta: 0.026, longitudeDelta: 0.005)
    )
    @State private var locations: [CustomPointAnnotation] = []  // アノテーションリスト
    @State private var selectedLocation: CLLocationCoordinate2D? = nil  // 選択した座標
    @State private var selectedLocationName: String = ""  // 選択した場所名
    @State private var navigateToNextView = false  // 次の画面に遷移するかを管理

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .foregroundColor(Color("BtnColor"))
                        .frame(width: 70)
                    VStack {
                        Text("STEP")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                        Text("1")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom, 8)
                .padding(.top, 24)

                Text("今回の集合場所を設定しよう")
                    .fontWeight(.heavy)
                    .padding(.bottom, 32)

                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("目的地を検索", text: $inputName, onCommit: {
                        searchLocation()
                    })
                    .padding(5)
                    .cornerRadius(5)
                    .frame(width: bounds.width * 0.8)
                }
                .padding([.leading, .trailing], 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.primary.opacity(0.6), lineWidth: 0.3)
                )
                .padding(.bottom, 8)

                Map(coordinateRegion: $region, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.annotation.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                }
                .border(.gray, width: 2)
                .frame(width: bounds.width * 0.8, height: bounds.width * 0.8)

                Spacer()
            }
            .frame(height: bounds.height * 0.7)

            NavigationLink(
                destination: CreateGameStepTwoVIew(meetingLocation: selectedLocationName),
                isActive: $navigateToNextView
            ) {
                EmptyView()
            }

            Button(action: {
                if !selectedLocationName.isEmpty {
                    navigateToNextView = true
                }
            }) {
                Btn(text: "次へ", bgColor: "BtnColor")
            }
            .disabled(selectedLocationName.isEmpty)

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

    private func searchLocation() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = inputName

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, let mapItem = response.mapItems.first else { return }

            DispatchQueue.main.async {
                let coordinate = mapItem.placemark.coordinate
                region.center = coordinate
                selectedLocation = coordinate

                let newLocation = MKPointAnnotation()
                newLocation.coordinate = coordinate
                newLocation.title = mapItem.name ?? "Unknown"

                self.locations = [CustomPointAnnotation(annotation: newLocation)]
                selectedLocationName = mapItem.placemark.title ?? inputName
            }
        }
    }
}

#Preview {
    CreateGameStepOenVIew()
}
