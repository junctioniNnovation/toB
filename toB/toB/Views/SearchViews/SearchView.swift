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
    @Binding var isSearchViewShoudShow: Bool
    @State var action: (String) -> Void
    
    let borderRadius = 10.0
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
            ZStack {
                Color.GrayScale.gray5.color
                VStack  {
                    searchArea
                        .padding(.top, 146)
                        .padding(.bottom, 9)
                        .background(
                            Rectangle()
                                .fill(Color.GrayScale.white.color)
                                .cornerRadius(borderRadius, corners: [.bottomLeft, .bottomRight])
                        )
                    Spacer(minLength: 22)
                    
                    if filteredPlaces.count > 0 {                            
                        ScrollView {
                            ForEach(filteredPlaces) { place in
                                VStack {
                                    searchRow(placeName: place.placeName, place: place.place, distance: place.distance, destination: $destination)
                                        .padding(.horizontal, 24)
                                    
                                    Divider()
                                        .frame(minHeight: 1)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.GrayScale.black.color)
                                }
                                .onTapGesture {
                                    destination = place.placeName
                                    action(destination)
                                }
                                .background(place.placeName == destination ? Color.mint : Color.clear)
                            }
                        }
                        .background(
                            Rectangle()
                                .fill(Color.GrayScale.white.color)
                                .cornerRadius(borderRadius, corners: [.topLeft, .topRight])
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Departure Point")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.GrayScale.black.color)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isSearchViewShoudShow.toggle()
                    } label: {
                        Image(systemName: BarItems.rightButton.label)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.GrayScale.black.color)
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    // Search Row List 커스텀 느낌
    private func searchRow(placeName: String, place: String, distance: String, destination: Binding<String>) -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .overlay(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(placeName)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                    Text(place)
                        .font(.system(size: 14))
                        .foregroundColor(Color.GrayScale.gray3.color)
                        .fontWeight(.medium)
                    Text(distance)
                        .font(.system(size: 13))
                        .foregroundColor(Color.GrayScale.gray2.color)
                }
            }
            .frame(maxWidth: .infinity)
    }
}
    
    
    // SearchView 위의 검색 뷰입니다.
extension SearchView {
    private var searchArea: some View {
        VStack {
            HStack(spacing: 14) {
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: 9, height: 9)
                
                TextField("Where are you arriving?", text: $destination)
                    .font(.system(size: 19))
                    .fontWeight(.semibold)
            }
            Divider()
                .frame(minHeight: 1)
                .frame(maxWidth: .infinity)
                .background(Color.GrayScale.black.color)
            
            HStack(spacing: 10) {
                Image(systemName: "location.circle")
                    .font(.system(size: 24))
                Image(systemName: "map")
                    .font(.system(size: 24))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 24)
            .padding(.top, 15)
        }
        .padding(.leading,24)
        .frame(maxWidth: .infinity)
    }
}
