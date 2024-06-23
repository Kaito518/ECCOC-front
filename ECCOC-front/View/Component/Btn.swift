//
//  Btn.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

struct InnerShadow: View {
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0), lineWidth: 2)
            // radius: 広がり
                .shadow(color: Color.black.opacity(0), radius: 4, x: 2, y: 2)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    //  インナーシャドウの色
                        .stroke(Color.black.opacity(0.25), lineWidth: 4)
                    //  ぼかし
                        .blur(radius: 4)
                    //   x軸とy軸
                        .offset(x: 0, y: 0)
                        .mask(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                )
        }
    }
}

struct Btn: View {
    var text: String
    var bgColor: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.system(size: 14))
        }
        .frame(width: 120,height: 40)
        .background(Color(bgColor))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.25), radius: 2, x: 2, y: 2)
        .overlay(InnerShadow())
    }
}

#Preview {
    Btn(text: "はい",bgColor: "BtnColor")
}
