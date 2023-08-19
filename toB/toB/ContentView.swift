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
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State var isSheetOn = true
    
    var body: some View {
        ZStack {
            UIMapView(coord: $locationManager.currentCoordinate)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                PathSelectionBottomSheetView()
                    .frame(alignment: .bottom)
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            currentCoordinate = location
            locationManager.stopUpdatingLocation()
        }
    }
}

struct UIMapView: UIViewRepresentable {
    @Binding var coord: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = NMFMyPositionMode.direction
        view.mapView.zoomLevel = 17.0
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let initialCoord = NMGLatLng(lat: coord.latitude, lng: coord.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: initialCoord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1.0
        uiView.mapView.moveCamera(cameraUpdate)
    }
}
