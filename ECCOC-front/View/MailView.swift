//
//  MailView.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

struct MailView: View {
    let names = ["tamagogirai", "mujica", "mirai", "LuckyMan"]
    
    var body: some View {
        HStack {
            Image("returnBtn")
                .padding()
            
            Spacer()
            
            Image("settingBtn")
                .offset(x: -12)
        }
        ScrollView{
            VStack(spacing: 0) {
                ForEach(names, id: \.self){ name in
                    MailBox(userName: name)
                }
            }
        }
    }
}

#Preview {
    MailView()
}
