//
//  SearchModel.swift
//  toB
//
//  Created by 김다빈 on 2023/08/19.
//

import Foundation
import SwiftUI

struct PlaceInfo: Identifiable,Hashable {
    let id = UUID()
    var placeName: String
    var place: String
    var distance: String
}
