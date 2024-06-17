//
//  NaviBar.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

struct NaviBarBase: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height - 95))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - 95))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct Circle: Shape {
    var r = CGFloat(80);
    var x = CGFloat(0);
    var y = CGFloat(0);
    
    let startAngle = Angle(degrees: 0-360)
    let endAngle   = Angle(degrees: 90-90)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: r,
            startAngle: startAngle,
            endAngle:   endAngle,
            clockwise: false
        )
        return path
    }
}

struct SemiCircle: Shape {
    var r = CGFloat(80);
    let startAngle = Angle(degrees: 0-170)
    let endAngle   = Angle(degrees: 90-100)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height - 75),
            radius: r,
            startAngle: startAngle,
            endAngle:   endAngle,
            clockwise: false
        )
        return path
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height - 85))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - 85))
        return path
    }
}


struct NaviBar: View {
    let charaFunc:() -> Void
    let homeFunc:() -> Void
    let gachaFunc:() -> Void
    let bounds = UIScreen.main.bounds;
    @State var count = 0;
    var body: some View {
        ZStack{
            NaviBarBase()
                .foregroundColor(.yellow)
            Circle(r: 60, x: bounds.width / 2, y: bounds.height - 75)
                .foregroundColor(.yellow)
            Line()
                .stroke(style: .init(lineWidth: 2, dash: [6, 3]))
                .foregroundColor(.white)
            Circle(r: 50, x: bounds.width / 2, y: bounds.height - 75)
                .foregroundColor(.yellow)
            SemiCircle(r: 50)
                .stroke(style: .init(lineWidth: 2,dash: [6, 3]))
                .foregroundColor(.white)
            Circle(r: 40, x: bounds.width / 2, y: bounds.height - 75)
                .foregroundColor(.white)
                .overlay(
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.red)
                        .position(x: bounds.width / 2, y: bounds.height - 75)
                )
                .onTapGesture {
                    homeFunc()
                }
            Image("chara")
                .resizable()
                .frame(width: 55, height: 45)
                .position(x: 80, y: bounds.height - 50)
                .onTapGesture {
                    charaFunc()
                }
            Text("キャラ")
                .font(.caption)
                .fontWeight(.bold)
                .position(x: 80, y: bounds.height - 15)
            Image("gacha")
                .resizable()
                .frame(width: 55, height: 45)
                .position(x: bounds.width - 80, y: bounds.height - 50)
                .onTapGesture {
                    gachaFunc()
                }
            Text("ガチャ")
                .font(.caption)
                .fontWeight(.bold)
                .position(x: bounds.width - 80, y: bounds.height - 15)
        }
    }
}

#Preview {
    NaviBar(
        charaFunc: {
            () -> Void in
        },
        homeFunc: {
            () -> Void in
        },
        gachaFunc: {
            () -> Void in
        }
    )
}
