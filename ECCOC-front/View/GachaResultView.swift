//
//  GachaResultView.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

struct GachaResultView: View {
    var CharaName: String
    var CharaExplanation: String
    
    var body: some View {
        VStack(spacing: 20) {
            TotalCoins(TotalC: 0)
            
            Image("taityou")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300,height: 300)
            
            VStack{
                HStack(spacing: 22){
                    Text("名前")
                        .foregroundColor(Color("sabu2"))
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    
                    Text(CharaName)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                .offset(x: -92,y: 10)
                
                ZStack{}
                    .frame(width: 350,height: 2)
                    .overlay(
                        GeometryReader { geometry in
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: geometry.size.height))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                            }
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [2, 2]))// 点と点の間隔を狭くします
                            .foregroundColor(Color("sabu2"))
                        }
                    )
                    .offset(x: 0,y: 4)

                
                    HStack(spacing: 20){
                        VStack {
                            Text("説明")
                                .foregroundColor(Color("sabu2"))
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .offset(x: 0,y: 0)
                            
                            Spacer()
                        }
                        ScrollView{
                            Text(CharaExplanation)
                                .frame(width: 260)
                        }
                    }
                    .offset(x: 0,y: 8)
                    
            }
            .frame(width: 350,height: 200)
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("sabu2"),lineWidth: 10)
            )
            
            Btn(text: "キャラ図鑑へ", bgColor: "BtnColor")

        }
        .offset(x: 0,y: -40)
    }
}

#Preview {
    GachaResultView(
        CharaName:"たいちょ",
        CharaExplanation:
            "探検隊の隊員として数多くの探索を成功させきた。\n\n好きなことは、寝ること"
    )
}
