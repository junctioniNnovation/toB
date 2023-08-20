//
//  PathSelectionBottomSheetView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct PathSelectionBottomSheetView: View {
    
    @State var numberOfTravelers = 1
    @State var isTravelerNumberSelected = false
    @State var viewHeight = 200.0
    @State var startPoint: String? = "Bexco"
    @State var endPoint: String?
    @State var isSheetUp = false
    @State var isSFullScreenUp = false
    @State var isSearchViewShoudShow = false
    @State var isStartpointPrimary = true
    @State var isEndpointPrimary = false
    
    var body: some View {
        ZStack {
            Color.background
            if isTravelerNumberSelected {
                DestinationSelectionView()
            } else {
                NumberOfTravelersSelectionView()
            }
        }
        .cornerRadius(12.0, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .frame(height: viewHeight)
    }
}


// MARK: - Destination Selection View

private extension PathSelectionBottomSheetView {
    
    @ViewBuilder
    func DestinationSelectionView() -> some View {
        VStack {
            VStack {
                HStack {
                    Text("\(numberOfTravelers) Travelers")
                        .font(.system(size: 14.0, weight: .semibold))
                        .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
                        .background(Color.Primary.light20.color)
                        .cornerRadius(7.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7.0)
                                .strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0)
                        )
                        .onTapGesture {
                            isTravelerNumberSelected.toggle()
                            withAnimation {
                                viewHeight = 200.0
                            }
                        }
                    Spacer()
                }
                .padding(EdgeInsets(top: 25.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                DestinationSelectorView(title: $startPoint, isPrimary: $isStartpointPrimary) {
                    // TODO: -
                }
                .padding(EdgeInsets(top: 20.0, leading: 0.0, bottom: 30.0, trailing: 0.0))
                DestinationSelectorView(title: $endPoint, isPrimary: $isEndpointPrimary) {
                    isSearchViewShoudShow.toggle()
                }
            }
            .offset(CGSize(width: 20.0, height: 0.0))
            Spacer()
            Button {
                guard endPoint != nil else {
                    isSFullScreenUp.toggle()
                    return
                }
                isSheetUp.toggle()
            } label: {
                ZStack {
                    Color.GrayScale.black.color
                    Text("Continue")
                        .foregroundColor(Color.GrayScale.white.color)
                }.frame(width: UIScreen.main.bounds.width - 36.0, height: 50.0)
                    .cornerRadius(16.0)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 60.0, trailing: 0.0))
            }
        }
        .fullScreenCover(isPresented: $isSearchViewShoudShow) {
            SearchView() { destination in
                endPoint = destination
                isEndpointPrimary = true
                isSearchViewShoudShow.toggle()
            }
        }
        .fullScreenCover(isPresented: $isSFullScreenUp) {
            TransferRecommendView(isScreenUp: $isSFullScreenUp, isFullScreen: true)
        }
        .fullScreenCover(isPresented: $isSheetUp) {
            SmallCarouselView(isSheetUp: $isSheetUp)
        }
    }
}


// MARK: - Number Of Travelers Selection View

private extension PathSelectionBottomSheetView {
    
    @ViewBuilder
    func NumberOfTravelersSelectionView() -> some View {
        VStack {
            VStack(spacing: 0) {
                HStack() {
                    Text("Number of Travelers")
                        .font(.system(size: 19.0, weight: .semibold))
                        .frame(alignment: .leading)
                    Spacer()
                    NumberOfTravelersButton()
                }
                HStack {
                    Text("For a maximum of 10 individuals")
                        .foregroundColor(Color.GrayScale.gray3.color)
                        .font(.system(size: 11.0, weight: .regular))
                        .frame(alignment: .leading)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 38.0, leading: 18.0, bottom: 0.0, trailing: 18.0))
            Button {
                isTravelerNumberSelected = true
                withAnimation {
                    viewHeight = 320.0
                }
            } label: {
                ZStack {
                    Color.GrayScale.black.color
                    Text("Continue")
                        .foregroundColor(Color.GrayScale.white.color)
                }.frame(width: UIScreen.main.bounds.width - 48.0, height: 50.0)
                    .cornerRadius(16.0)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 60.0, trailing: 0.0))
                
            }
            
        }
    }
}


// MARK: - Button

private extension PathSelectionBottomSheetView {
    
    @ViewBuilder
    func NumberOfTravelersButton() -> some View {
        HStack {
            Button {
                guard numberOfTravelers > 1 else { return }
                numberOfTravelers -= 1
            } label: {
                Text("-")
                    .foregroundColor(numberOfTravelers > 1 ? Color.GrayScale.gray3.color : Color.GrayScale.gray5.color)
            }
            .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 0.0))
            Spacer()
            Text("\(numberOfTravelers)")
            Spacer()
            Button {
                guard numberOfTravelers < 10 else { return }
                numberOfTravelers += 1
            } label: {
                Text("+")
                    .foregroundColor(numberOfTravelers < 10 ? Color.GrayScale.gray3.color : Color.GrayScale.gray5.color)
            }.padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 10.0))
        }
        .frame(width: 95.0, height: 31.0)
        .background(Color.GrayScale.gray6.color)
        .cornerRadius(7.0)
        .overlay(
            RoundedRectangle(
                cornerSize: .init(width: 7.0, height: 7.0)
            )
            .strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0)
        )
    }
}
