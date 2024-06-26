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
    var gameViewModel = false;
    // 東京駅の座標
    @State private var position: MapCameraPosition = .region(.init(
        center: .init(latitude: 35.681236, longitude: 139.767125),
        span: .init(latitudeDelta: 0.026, longitudeDelta: 0.005)
    ))
    
    var num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let bounds = UIScreen.main.bounds;
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Map(position: $position) {
                    if(gameViewModel){
                        ForEach(Array(num.enumerated()), id: \.element) { index, _ in
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.682 + Double.random(in: -0.01...0.01),longitude: 139.766 + Double.random(in: -0.01...0.01))) {
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
                            }
                        }
                    }
                }
                if(!gameViewModel){
                    ZStack{
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
                        .stroke(style: .init(lineWidth: 2,dash: [6, 3]))
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
            .navigationDestination(for: Router.self, destination: { append in
                append.Destination()
                    .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}


#Preview {
    MapView()
}
