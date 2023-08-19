//
//  SearchModel.swift
//  toB
//
//  Created by 김다빈 on 2023/08/19.
//


import Foundation
import SwiftUI


// MARK: 기존의 모델에서 위도와 경도를 옵셔널로 추가했어요 위도와 경도를 추가함으로써 길찾기 api를 통해 빠른 비교가 가능해졌습니다.
struct PlaceInfo: Identifiable,Hashable {
    let id = UUID()
    var placeName: String
    var place: String
    var distance: String
    var longtitude : Double?
    var latitude : Double?
}


