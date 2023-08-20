//
//  SmallCarouselView.swift
//  toB
//
//  Created by 김수환 on 2023/08/20.
//

import SwiftUI

struct SmallCarouselView: View {
    @StateObject var locationManager = LocationManager()
    @Binding var isSheetUp: Bool
    var body: some View {
        VStack {
            Header()
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            UIMapView(coord: $locationManager.currentCoordinate)
            TransferRecommendView(isScreenUp: $isSheetUp, isFullScreen: false)
                .cornerRadius(12.0, corners: [.topLeft, .topRight])
        }
    }
}


// MARK: - Header

private extension SmallCarouselView {
    
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Button {
                isSheetUp.toggle()
            } label: {
                Image(systemName: "chevron.left").frame(alignment: .leading)
                    .tint(Color.GrayScale.black.color)
            }
            Spacer()
            Text("Transportation")
                .frame(alignment: .center)
                .fontWeight(.bold)
            Spacer()
        }
    }
}
