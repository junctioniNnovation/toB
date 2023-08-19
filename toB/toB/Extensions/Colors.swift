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
        case light40
        case light60
        
        var color: Color {
            switch self {
            case .main:
                return Color("PrimaryMain")
            case .light:
                return Color("PrimaryLight")
            case .light20:
                return Color("PrimaryLight20")
            case .light40:
                return Color("PrimaryLight40")
            case .light60:
                return Color("PrimaryLight60")
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
                return Color("GrayscaleBlack")
            case .gray1:
                return Color("GrayscaleGray1")
            case .gray2:
                return Color("GrayscaleGray2")
            case .gray3:
                return Color("GrayscaleGray3")
            case .gray4:
                return Color("GrayscaleGray4")
            case .gray5:
                return Color("GrayscaleGray5")
            case .gray6:
                return Color("GrayscaleGray6")
            case .white:
                return Color("GrayscaleWhite")
            }
        }
    }
    
    enum Tag: iNnovationColors {
        case blue
        case green
        case pink
        case yellow
        case purple
        
        var color: Color {
            switch self {
            case .blue:
                return Color("TagBlue")
            case .green:
                return Color("TagGreen")
            case .pink:
                return Color("TagPink")
            case .yellow:
                return Color("TagYellow")
            case .purple:
                return Color("TagPurple")
            }
        }
    }
}


// MARK: - Protocol

protocol iNnovationColors {
    
    var color: Color { get }
}
