//
//  CustomAnnotations.swift
//  ECCOC-front
//
//  Created by 肥後凱斗 on 2025/02/06.
//

import Foundation
import MapKit

// カスタムアノテーション構造体（ゲーム用）
struct CustomPointAnnotation: Identifiable {
    let id = UUID()
    let annotation: MKPointAnnotation
}
