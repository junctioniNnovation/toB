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
    let uuid = UUID()
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
    @Binding var isArrivalRecommendViewShouldShow: Bool
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    var body: some View {
        NavigationStack {
            VStack {
                UIMapView(coord: coord)
                
                RecommendScrollView()
                    .cornerRadius(12.0, corners: [.topLeft, .topRight])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isArrivalRecommendViewShouldShow.toggle()
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
    
    @State private var selectedBoxIndex: Int? = nil
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20.0    ) {
                        ForEach(1..<5) { index in
                            BoxInfo(
                                index: index,
                                location: Constant.location,
                                selectedBoxIndex: $selectedBoxIndex
                            ) { index in
                                selectedBoxIndex = index
                            }
                        }
                    }
                    .padding(.top, 25.0)
                }
                if selectedBoxIndex != nil {
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        ZStack {
                            Color.GrayScale.black.color
                            Text("Set as destination")
                                .foregroundColor(Color.GrayScale.white.color)
                        }.frame(width: UIScreen.main.bounds.width - 36.0, height: 50.0, alignment: .bottom)
                            .cornerRadius(16.0)
                            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 60.0, trailing: 0.0))
                            .background(Color.white)
                    }
                }
            }
        }
    }
}


// MARK: - Constant

private extension RecommendScrollView {
    
    enum Constant {
        static let location = Location(
            place: "Bexco",
            duration: 20,
            distance: 90,
            price: 20000,
            address: "55, APEC-ro, Haeundae-gu, Busan, Republic of Korea"
        )
    }
}


// MARK: - BoxInfo

struct BoxInfo: View {
    let index: Int
    let location: Location
    @Binding var selectedBoxIndex: Int?
    let action: (Int) -> Void
    
    var body: some View {
        Button {
            action(index)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Metric.boxRadius)
                    .inset(by: 0.5)
                    .stroke(handleBoxStrokeAndTextColor(selectedIndex: selectedBoxIndex))
                    .background(handleBoxColor(selectedIndex: selectedBoxIndex))
                    .cornerRadius(Metric.boxRadius)
                
                VStack(spacing: 3.0) {
                    Text(location.place)
                        .font(.system(size: 20.0))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(handleBoxStrokeAndTextColor(selectedIndex: selectedBoxIndex))
                    
                    HStack(spacing: 13.0) {
                        Text("\(location.duration)min")
                        Text("\(location.distance)km")
                        Text("\(location.price)won")
                    }
                    .font(.system(size: 12.0))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(handleBoxStrokeAndTextColor(selectedIndex: selectedBoxIndex))
                    
                    Text(location.address)
                        .font(.system(size: 10.0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 13.5)
            }
            .padding(.horizontal, 24.0)
            .foregroundColor(Color.GrayScale.black.color)
        }
    }
    func handleBoxStrokeAndTextColor(selectedIndex: Int?) -> Color {
        guard let selectedIndex else {
            return .GrayScale.black.color
        }
        return selectedIndex == index ? .GrayScale.black.color : .GrayScale.gray4.color
    }
    func handleBoxColor(selectedIndex: Int?) -> Color {
        return selectedIndex == index ? Color.Primary.light.color : .clear
    }
}


// MARK: - Constant

private extension BoxInfo {
    
    enum Metric {
        static let boxRadius: CGFloat = 12.0
    }
}
