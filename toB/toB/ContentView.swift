//
//  ContentView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import MapKit
import SwiftUI
import UIKit
import NMapsMap

struct ContentView: View {
    
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    @State var isSheetOn = true
    
    var body: some View {
        ZStack {
            UIMapView(coord: coord)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                PathSelectionBottomSheetView()
                    .frame(alignment: .bottom)
            }
        }
    }
}


struct UIMapView: UIViewRepresentable {

    var coord: (Double, Double)

    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17.0

        return view
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1.0
        uiView.mapView.moveCamera(cameraUpdate)}
}
