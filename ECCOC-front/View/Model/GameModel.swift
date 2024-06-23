//
//  GameModel.swift
//  ECCOC-front
//
//  Created by 久乗建汰 on 2024/06/23.
//

import Foundation

struct GameModel {
    enum Game:String { // ケースは犬か猫か
        case play
        case notPlay
    }

    var game: Game = .notPlay // 初期値は犬

    mutating func switchPlay() { // 犬と猫を切り替える関数
        if game == .play {
            game = .notPlay
        } else {
            game = .play
        }
    }

}
