//
//  Colors.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

extension Color {
    
    static let background = Color("Background")
    
    enum Primary: iNnovationColors {
        case main
        case light
        case light20
        
        var color: Color {
            switch self {
            case .main:
                return Color("PrimaryMain")
            case .light:
                return Color("PrimaryLight")
            case .light20:
                return Color("PrimaryLight20")
            }
        }
    }
    
    enum Secondary: iNnovationColors {
        case main
        case light
        case light20
        
        var color: Color {
            switch self {
            case .main:
                return Color("SecondaryMain")
            case .light:
                return Color("SecondaryLight")
            case .light20:
                return Color("SecondaryLight20")
            }
        }
    }
    enum GrayScale: iNnovationColors {
        case black
        case gray1
        case gray2
        case gray3
        case gray4
        case gray5
        case gray6
        case white
        
        var color: Color {
            switch self {
            case .black:
                return Color("GrayScaleBlack")
            case .gray1:
                return Color("GrayScaleGray1")
            case .gray2:
                return Color("GrayScaleGray2")
            case .gray3:
                return Color("GrayScaleGray3")
            case .gray4:
                return Color("GrayScaleGray4")
            case .gray5:
                return Color("GrayScaleGray5")
            case .gray6:
                return Color("GrayScaleGray6")
            case .white:
                return Color("GrayScaleWhite")
            }
        }
    }
}


protocol iNnovationColors {
    
    var color: Color { get }
}
