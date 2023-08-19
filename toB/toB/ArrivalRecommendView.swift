//
//  ArrivalRecommentView.swift
//  toB
//
//  Created by Nayeon Kim on 2023/08/19.
//

import SwiftUI
import UIKit
import NMapsMap

struct Location {
    let place: String
    let duration: Int
    let distance: Int
    let price: Int
    let address: String
}

enum BarItems {
    case leftButton
    case title
    case rightButton
    
    var label: String {
        switch self {
        case .leftButton:
            return "chevron.left"
        case .title:
            return "Destination Recommend"
        case .rightButton:
            return "xmark"
        }
    }
}

struct ArrivalRecommendView: View {
    @Binding var isArrivalRecommendViewShowShow: Bool
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    var body: some View {
        NavigationStack {
            VStack {
                UIMapView(coord: coord)
                
                RecommendScrollView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isArrivalRecommendViewShowShow.toggle()
                    } label: {
                        Image(systemName: BarItems.leftButton.label)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.GrayScale.black.color)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    
                    Text(BarItems.title.label)
                        .fontWeight(.semibold)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RecommendScrollView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(1..<5) { _ in
                    BoxInfo()
                }
            }
            .padding(.top, 25)
        }
    }
}

struct BoxInfo: View {
    let bexco = Location(place: "Bexco", duration: 20, distance: 90, price: 20000, address: "55, APEC-ro, Haeundae-gu, Busan, Republic of Korea")
    let boxRadius: CGFloat = 12
    
    @State var isBoxSelected = false
    
    var body: some View {
        Button {
            handleButton(isBoxSelected)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: boxRadius)
                    .inset(by: 0.5)
                    .stroke(Color.GrayScale.black.color)
                    .background(handleBoxColor(isBoxSelected))
                    .cornerRadius(boxRadius)
                
                VStack(spacing: 3) {
                    Text(bexco.place)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 13) {
                        Text("\(bexco.duration)min")
                        Text("\(bexco.distance)km")
                        Text("\(bexco.price)won")
                    }
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(bexco.address)
                        .font(.system(size: 10))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 13.5)
            }
            .padding(.horizontal, 24)
            .foregroundColor(Color.GrayScale.black.color)
        }
    }
    func handleButton(_ isBoxSelected: Bool) {
        self.isBoxSelected.toggle()
    }
    
    func handleBoxColor(_ isBoxSelected: Bool) -> Color {
        if !isBoxSelected {
            return .clear
        } else {
            return Color.Primary.light.color
        }
    }
}
