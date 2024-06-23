//
//  CharacterCatalogView.swift
//  ECCOC-front
//
//  Created by Kodai Hirata on 2024/06/21.
//

import SwiftUI

struct CharacterCatalogView: View {
    var ReleasedCharacter: String
    
    @State private var selectedCatalog: String?
    let Catalogs = ["隊員","たいちょ","くまさん","ぐまさん","囚人","コリパ","スライム","Sキング","看守","?","?","?"]
    
    init(ReleasedCharacter: String) {
            self.ReleasedCharacter = ReleasedCharacter
            _selectedCatalog = State(initialValue: ReleasedCharacter)
        }
    
    var body: some View {
        VStack {
            ZStack {
                HStack{}
                    .frame(width: 240,height: 50)
                    .background(Color("sabu2"))
                    .offset(x: 5,y: 5)
                
                Text(selectedCatalog ?? "Default Text")
                    .fontWeight(.bold)
                    .frame(width: 240,height: 50)
                    .background(Color.white)
                    .border(Color.black, width:2)
            }
            
            Image(selectedCatalog ?? "Default Text")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300,height: 300)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 73))]) {
                    ForEach(Catalogs, id: \.self){ Catalog in
                        VStack {
                            if Catalog == "?" {
                                Image("QuestionCard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80,height: 120)
                            } else {
                                Image(Catalog)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 78,height: 78)
                            }
                            
                            if Catalog != "?" {
                                ZStack {
                                    Image(selectedCatalog == Catalog ? "SelectedTags" : "UnselectedTags")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    .frame(width: 70,height: 15)
                                    
                                    Text(Catalog)
                                        .font(.system(size: 10))
                                        .foregroundColor(Color.white)
                                }
                            }
                                
                        }
                        .frame(width: 80,height: 120)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCatalog == Catalog ? Color("sabu2") : Color.clear, lineWidth: 4)
                        )
                        .onTapGesture {
                            selectedCatalog = Catalog
                        }
                    }
                }
                .offset(x: 0,y: 20)
            }
            .frame(maxWidth: .infinity,minHeight: 330)
            .background(Color("Mailbg"))
        }
        .offset(x: 0,y: 50)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CharacterCatalogView(ReleasedCharacter: "たいちょ")
}
