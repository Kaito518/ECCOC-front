//
//  CharacterCatalogView.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

class CharacterViewModel: ObservableObject {
    @Published var selectedCharacterForHome: String? = "隊員" // Default for HomeView
    @Published var currentCharacterForCatalog: String = "隊員" // Default for CharacterCatalogView
}

struct CharacterCatalogView: View {
    @ObservedObject var characterViewModel: CharacterViewModel
    
    let Catalogs = ["隊員", "たいちょ", "くまさん", "ぐまさん", "囚人", "コリパ", "スライム", "Sキング", "看守", "?", "?", "?"]

    var body: some View {
        VStack {
            // キャラ名の表示（青枠）
            ZStack {
                // ✅ 背景色（選択前は #7BBD31、選択中は #0096DE）
                Rectangle()
                    .fill(characterViewModel.selectedCharacterForHome == characterViewModel.currentCharacterForCatalog ? Color(hex: "0096DE") : Color(hex: "7BBD31"))
                    .frame(width: 180, height: 41)
                    .offset(x:5,y: 6) // ✅ ちょっと下にずらす

                // ✅ 白背景のボックス
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 180, height: 40)

                // ✅ 黒枠（常に表示）
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 180, height: 40)

                // ✅ キャラ名テキスト
                Text(characterViewModel.currentCharacterForCatalog)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
            .padding(.top, 10)
            
            // キャラクター画像と選択ボタン
            ZStack {
                Image(characterViewModel.currentCharacterForCatalog)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)

                Button(action: {
                    if characterViewModel.selectedCharacterForHome == characterViewModel.currentCharacterForCatalog {
                        characterViewModel.selectedCharacterForHome = nil
                    } else {
                        characterViewModel.selectedCharacterForHome = characterViewModel.currentCharacterForCatalog
                    }
                }) {
                    Image(characterViewModel.selectedCharacterForHome == characterViewModel.currentCharacterForCatalog ? "sentakuchu" : "sentakusuru")
                        .resizable()
                        .frame(width: 90, height: 35)
                }
                .offset(x: 130, y: 110) // キャラの右下に配置
            }
            .padding(.top, 10)

            Spacer()

            // キャラ一覧（横4列、間隔を調整）
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)],
                    spacing: 8 // ✅ 行間のスペースを少し狭く
                ) {
                    ForEach(Catalogs, id: \.self) { catalogItem in
                        VStack {
                            if catalogItem == "?" {
                                Image("QuestionCard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 85, height: 120) // ✅ サイズ調整
                            } else {
                                Image(catalogItem)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 85, height: 85) // ✅ サイズ調整
                            }

                            if catalogItem != "?" {
                                ZStack {
                                    Image(characterViewModel.selectedCharacterForHome == catalogItem ? "SelectedTags" : "UnselectedTags")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 14) // ✅ サイズ調整
                                    
                                    Text(catalogItem)
                                        .font(.system(size: 10)) // ✅ 文字サイズを調整
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .frame(width: 95, height: 110) // ✅ キャラ枠サイズを大きく調整
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(characterViewModel.selectedCharacterForHome == catalogItem ? Color("sabu2") : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            characterViewModel.currentCharacterForCatalog = catalogItem
                        }
                    }
                }
                .padding(.top, 12) // ✅ 上の余白も微調整
            }
            .frame(maxWidth: .infinity, minHeight: 320) // ✅ 高さを微調整
            .background(Color("Mailbg"))
        }
        .padding(.top, 20)
        .navigationBarBackButtonHidden(true)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 1.0
            g = 1.0
            b = 1.0
        }
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    CharacterCatalogView(characterViewModel: CharacterViewModel()) // Pass the ViewModel instance
}
