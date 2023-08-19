//
//  SearchView.swift
//  toB
//
//  Created by 김다빈 on 2023/08/19.
//

import SwiftUI


struct SearchView: View {
    // 시작점: -> 변수이름 변경하는 것도 낫배드
    @State private var destination: String = ""
    @State private var endPoint: String = ""
    @State var action: (String) -> Void
    // State로 endPoint와 destination
    // MARK: 더미데이터들 같은 뷰에서 재탕을 할꺼에요
    var busStopList = [
        PlaceInfo(placeName: "Busan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Busan West Bus Terminal", place: "Bus Station", distance: "15.7km"),
        PlaceInfo(placeName: "Busan Haeundae Bus Terminal", place: "Bus Station", distance: "2.9km"),
        PlaceInfo(placeName: "Ansan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Suwon Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
    ]
    
    //
    var famousePlace = [
        PlaceInfo(placeName: "Busan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Busan West Bus Terminal", place: "Bus Station", distance: "15.7km"),
        PlaceInfo(placeName: "Busan Haeundae Bus Terminal", place: "Bus Station", distance: "2.9km"),
        PlaceInfo(placeName: "Ansan Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
        PlaceInfo(placeName: "Suwon Central Bus Terminal", place: "Bus Station", distance: "14.1km"),
    ]
    
    // 검색 기능
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
    // 메인뷰
    var body: some View {
        NavigationView {
            VStack {
                searchArea
                List(filteredPlaces, id: \.self) { place in
                    searchRow(placeName: place.placeName, place: place.place, distance: place.distance, destination: $destination)
                        .onTapGesture {
                            destination = place.placeName
                            action(destination)
                        }
                        .listRowBackground(place.placeName == destination ? Color.mint : Color.clear)
                        
                    
                }
                
                .navigationTitle("Departure Point")
                .navigationBarItems(trailing: Image(systemName: ""))
            }
        }
        
        
    }
}
// Search Row List 커스텀 느낌
private func searchRow(placeName: String, place: String, distance: String, destination: Binding<String>) -> some View {
    Rectangle()
        .foregroundColor(.clear)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .overlay(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(placeName)
                    .font(.system(size: 17))
                Text(place)
                    .font(.system(size: 14))
                Text(distance)
                    .font(.system(size: 13))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        
}


// SearchView 위의 검색 뷰입니다.
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
