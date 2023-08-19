//
//  SearchView.swift
//  toB
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
        PlaceInfo(placeName: "Ansan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Suwon Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
    ]
    
    var filteredPlaces: [PlaceInfo] {
           if destination.isEmpty {
               return []
           } else {
               return busStopList.filter {
                   let placeNameLowercased = $0.placeName.lowercased()
                   let destinationLowercased = destination.lowercased()
                   return placeNameLowercased.contains(destinationLowercased)
               }
           }
       }
    
    var body: some View {
        NavigationView {
            VStack {
                searchArea
                List(filteredPlaces, id: \.self) { place in
                    searchRow(placeName: place.placeName, place: place.place, distance: place.distance)
                        .background(place.placeName == destination ? Color.blue : Color.clear)
                        .onTapGesture {
                            destination = place.placeName
                        }
                        .ignoresSafeArea()
                    
                }
                .navigationTitle("Departure Point")
                .navigationBarItems(trailing: Image(systemName: ""))
            }
            .foregroundColor(.black)
        }
        
        
    }
}

private func searchRow(placeName: String, place: String, distance: String) -> some View {
    Rectangle()
        .foregroundColor(.clear)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .overlay(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(placeName)
                Text(place)
                Text(distance)
            }
        }
}



extension SearchView {
    private var searchArea: some View {
        VStack {
            HStack {
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: 9,height: 9)
                
                
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
    
    
}



