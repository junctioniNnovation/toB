//
//  SmallCarouselView.swift
//  toB
//
//  Created by 김수환 on 2023/08/20.
//

import SwiftUI
import NMapsMap

struct SmallCarouselView: View {
    @StateObject var locationManager = LocationManager()
    @Binding var isSheetUp: Bool
    @State var lineString = NMGLineString(points: []) as NMGLineString<AnyObject>
    var body: some View {
        VStack {
            Header()
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            UIMapView(coord: $locationManager.currentCoordinate, lineString: $lineString)
            TransferRecommendView(isScreenUp: $isSheetUp, isFullScreen: false) { index in
                lineString = test[index]
            }
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


let test = [
    NMGLineString(points: [
        NMGLatLng(lat:35.158223, lng: 129.170924),
        NMGLatLng(lat:35.159260, lng: 129.170146),
        NMGLatLng(lat:35.161112, lng: 129.171540),
        NMGLatLng(lat:35.156361, lng: 129.177946),
        NMGLatLng(lat:35.164246, lng: 129.185680),
        NMGLatLng(lat:35.162257, lng: 129.187934),
        NMGLatLng(lat:35.160306, lng: 129.191395),
        NMGLatLng(lat:35.175832, lng: 129.183867),
        NMGLatLng(lat:35.183720, lng: 129.210448),
        NMGLatLng(lat:35.199147, lng: 129.223787),
        NMGLatLng(lat:35.200206, lng: 129.229012),

    ]) as NMGLineString<AnyObject>,
    
    NMGLineString(points: [
        NMGLatLng(lat:35.156654, lng: 129.170362),
        NMGLatLng(lat:35.159260, lng: 129.170146),
        NMGLatLng(lat:35.153137, lng: 129.180599),
        NMGLatLng(lat:35.156838, lng: 129.189200),
        NMGLatLng(lat:35.165187, lng: 129.199710),
        NMGLatLng(lat:35.176731, lng: 129.201705),
        NMGLatLng(lat:35.179999, lng: 129.207911),
        NMGLatLng(lat:35.156751, lng: 129.181673),

    ]) as NMGLineString<AnyObject>
    ,
    NMGLineString(points: [
        NMGLatLng(lat:35.158223, lng: 129.170924),
        NMGLatLng(lat:35.159260, lng: 129.170146),
        NMGLatLng(lat:35.161112, lng: 129.171540),
        NMGLatLng(lat:35.156361, lng: 129.177946),
        NMGLatLng(lat:35.164246, lng: 129.185680),
        NMGLatLng(lat:35.162257, lng: 129.187934),
        NMGLatLng(lat:35.160306, lng: 129.191395),
        NMGLatLng(lat:35.175832, lng: 129.183867),
        NMGLatLng(lat:35.183720, lng: 129.210448),
        NMGLatLng(lat:35.199147, lng: 129.223787),
        NMGLatLng(lat:35.200206, lng: 129.229012),

    ]) as NMGLineString<AnyObject>
    ,
    NMGLineString(points: [
        NMGLatLng(lat:35.158223, lng: 129.170924),
        NMGLatLng(lat:35.159260, lng: 129.170146),
        NMGLatLng(lat:35.161112, lng: 129.171540),
        NMGLatLng(lat:35.156361, lng: 129.177946),
        NMGLatLng(lat:35.164246, lng: 129.185680),
        NMGLatLng(lat:35.162257, lng: 129.187934),
        NMGLatLng(lat:35.160306, lng: 129.191395),
        NMGLatLng(lat:35.175832, lng: 129.183867),
        NMGLatLng(lat:35.183720, lng: 129.210448),
        NMGLatLng(lat:35.199147, lng: 129.223787),
        NMGLatLng(lat:35.200206, lng: 129.229012),

    ]) as NMGLineString<AnyObject>,
    NMGLineString(points: [
        NMGLatLng(lat:35.158223, lng: 129.170924),
        NMGLatLng(lat:35.159260, lng: 129.170146),
        NMGLatLng(lat:35.161112, lng: 129.171540),
        NMGLatLng(lat:35.156361, lng: 129.177946),
        NMGLatLng(lat:35.164246, lng: 129.185680),
        NMGLatLng(lat:35.162257, lng: 129.187934),
        NMGLatLng(lat:35.160306, lng: 129.191395),
        NMGLatLng(lat:35.175832, lng: 129.183867),
        NMGLatLng(lat:35.183720, lng: 129.210448),
        NMGLatLng(lat:35.199147, lng: 129.223787),
        NMGLatLng(lat:35.200206, lng: 129.229012),

    ]) as NMGLineString<AnyObject>
]
