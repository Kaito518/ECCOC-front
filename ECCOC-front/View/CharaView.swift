//
//  SettingView.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/17.
//

import SwiftUI

struct CharaView: View {
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List{
                NavigationLink(Router.root.toString, value: Router.root)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Router.self, destination: { append in
                append.Destination()
                    .navigationTitle(append.toString)
                    .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}

#Preview {
    CharaView()
}
