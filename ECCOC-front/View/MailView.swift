//
//  MailView.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

struct MailView: View {
    @ObservedObject var characterViewModel: CharacterViewModel // 追加

    let names = ["tamagogirai", "mujica", "mirai", "LuckyMan"]
    
    var body: some View {
        HStack {
            NavigationLink(destination: HomeView(characterViewModel: characterViewModel).navigationBarBackButtonHidden(true)) {
                Image("returnBtn")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .offset(x: 12)
            
            Spacer()
            
            Image("settingBtn")
                .offset(x: -12)
        }
        ScrollView {
            VStack(spacing: 0) {
                ForEach(names, id: \.self) { name in
                    MailBox(userName: name)
                }
            }
        }
    }
}

#Preview {
    MailView(characterViewModel: CharacterViewModel()) // Pass the ViewModel
}
