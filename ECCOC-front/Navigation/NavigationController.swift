//
//  NavigationController.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2025/02/06.
//

import SwiftUI

class NavigationController: ObservableObject {
    @Published var path = NavigationPath()

    func popToRoot() {
        DispatchQueue.main.async {
            self.path = NavigationPath()
        }
    }

    func push<T: Hashable>(_ value: T) {
        path.append(value)
    }

    func pop() {
        path.removeLast()
    }
}
