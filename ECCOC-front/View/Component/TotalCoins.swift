//
//  TotalCoins.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/20.
//

import SwiftUI

struct TotalCoins: View {
    var TotalC: Int
    
    var body: some View {
        HStack {
            Image("coin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60,height: 40)
                .padding(.leading, 6)
            
            Spacer()
            
            Text(String(TotalC))
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.trailing, 10)
        }
        .frame(width: 200, height: 40)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("BtnColor"),lineWidth: 3)
        )
    }
}

#Preview {
    TotalCoins(TotalC: 1000)
}
