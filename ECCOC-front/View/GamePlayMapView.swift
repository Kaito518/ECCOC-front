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
    var gameViewModel = true;
    @State var isStart = false;
    // 東京駅の座標
    @State private var position: MapCameraPosition = .region(.init(
        center: .init(latitude: 35.681236 - 0.0074, longitude: 139.767 + 0.0062),
        span: .init(latitudeDelta: 0.026, longitudeDelta: 0.005)
    ))
    
    let bounds = UIScreen.main.bounds;
    @State var path = NavigationPath()
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                if(gameViewModel){
                    ForEach(0..<30) { index in
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.682 + Double.random(in: -0.02...0.02),longitude: 139.766 + Double.random(in: -0.02...0.02))) {
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
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.682 - 0.006 ,longitude: 139.766 + 0.006)) {
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
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.681236 ,longitude: 139.767125)) {
                    Image("gool")
                        .resizable()
                        .frame(width: 40, height: 60)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .yellow)
                        .cornerRadius(50)
                }
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: 35.681236 - 0.0074 ,longitude: 139.767 + 0.0062)) {
                    Image("me")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .yellow)
                        .cornerRadius(50)
                }
            }
            .onAppear{
                withAnimation(.linear(duration: 0.8)) {
                    isStart = true
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
                    .foregroundStyle(.red)
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
                    
                    Text("ゲーム作成")
                        .bold()
                        .foregroundStyle(.white)
                        .position(CGPoint(x: bounds.width - 76.5, y: bounds.height - 170))
                }
            }
            
            if(isStart) {
                Image("start")
            }
            
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(gameViewModel ? .cyan : .clear, lineWidth: 16)
        )
        .ignoresSafeArea(.all)
    }
}

#Preview {
    GamePlayMapView()
}
