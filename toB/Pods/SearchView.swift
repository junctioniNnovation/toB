//
//  SearchView.swift
//  Pods-toB
//
//  Created by 김다빈 on 2023/08/19.
//

import SwiftUI


struct SearchView: View {
    @State private var destination: String = ""
    @State private var isSelected: Bool = false
    
    var busStopList = [
        PlaceInfo(placeName: "Busan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Busan Wset Bus Terminal", place: "Bus Station", distance: "15.7km"),
        PlaceInfo(placeName: "Busan Haeundae Bus Terminal", place: "Bus Station", distance: "2.9km"),
        PlaceInfo(placeName: "Busan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Busan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
    ]
    
    var filteredPlaces: [PlaceInfo] {
        if destination.isEmpty {
            return Array(busStopList.sorted { $0.placeName < $1.placeName }.prefix(3))
        } else {
            return busStopList.filter {$0.placeName.lowercased().contains(destination.lowercased())}
                .sorted { Double($0.distance.replacingOccurrences(of: "km", with: "")) ?? 0
                    < Double($1.distance.replacingOccurrences(of: "km", with: "")) ?? 0 }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchArea(destination: destination)
                List(filteredPlaces) { place in
                                  searchRow(placeName: place.placeName, place: place.place, distance: place.distance)
                              }
            }
            .navigationTitle("Departure Point")
            .navigationBarItems(trailing: Image(systemName: ""))
        }
    }
    
   
}


private func searchArea(@State destination: String) -> some View {
    VStack {
        HStack {
            Circle()
            TextField("Where are you arriving?", text: $destination)
                .font(.system(size: 19))
        }
        Divider()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .padding(.leading,20)
        HStack {
            Spacer()
            Image(systemName: "paperplane.circle")
                .padding(.trailing,10)
            Image(systemName: "map")
                .padding(.trailing,20)
        }
    }
    .padding(.leading,24)
    .frame(maxWidth: .infinity)
}

private func searchRow(placeName: String, place: String, distance: String) -> some View {
    Rectangle()
        .frame(maxWidth: .infinity)
        .overlay {
            VStack(alignment: .leading) {
                Text(placeName)
                Text(place)
                Text(distance)
            }
        }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
