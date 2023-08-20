//
//  TransferRecommendView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct TransferRecommendView: View {
    
    @State var ontab: Bool = false
    @State var background: Color = .clear
    @State var currentIndex: Int = 0
    @State private var shouldTransition = true
    @Binding var isScreenUp: Bool
    @State var isArrivalRecommendViewShouldShow = false
    @State var transfertationList = transfertationListData
    var isFullScreen = false
    
    private let maxScaleEffect: CGFloat = 4.0
    private let minScaleEffect: CGFloat = 0
    
    var body: some View {
        ZStack{
            background.ignoresSafeArea()
            VStack {
                if isFullScreen {
                    Header()
                }
                CustomCarousel(
                    index: $currentIndex,
                    items: transfertationList,
                    spacing: UIScreen.main.bounds.width / 3,
                    cardPadding: 24.0,
                    id: \.self,
                    isFullScreen: isFullScreen
                ) { transfertation, _, _ in
                    if isFullScreen {
                        FullscreenCard(transfertation: transfertation)
                    } else {
                        SheetCard(transfertation: transfertation)
                    }
                }
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: isFullScreen ? 53.0 : 37.0, trailing: 0.0))
                
                
                HStack {
                    Button {
                        let currentTransfertation = transfertationList[currentIndex]
                        transfertationList.remove(at: currentIndex)
                        transfertationList.append(currentTransfertation)
                    } label: {
                        Circle()
                            .overlay(Circle().fill(Color.GrayScale.gray5.color))
                            .overlay(Circle().strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                            .overlay(Image("Xmark"))
                            .frame(width: 66.0, height: 66.0)
                    }
                    Spacer()
                    Button {
                        guard isFullScreen else {
                            // TODO: -
                            return
                        }
                        isArrivalRecommendViewShouldShow.toggle()
                    } label: {
                        Circle()
                            .overlay(Circle().fill(Color.Primary.main.color))
                            .overlay(Circle().strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                            .overlay(Image("Check"))
                            .frame(width: 66.0, height: 66.0)
                    }
                }
                .padding(EdgeInsets(top: 0.0, leading: 24.0, bottom: 0.0, trailing: 24.0))
                Spacer()
            }.padding([.horizontal,.top], 15)
        }.presentationDetents([.medium])
            .fullScreenCover(isPresented: $isArrivalRecommendViewShouldShow) {
                ArrivalRecommendView(isArrivalRecommendViewShouldShow: $isArrivalRecommendViewShouldShow)
            }
    }
}


// MARK: - Header

private extension TransferRecommendView {
    
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Button {
                isScreenUp.toggle()
            } label: {
                Image(systemName: "chevron.left").frame(alignment: .leading)
                    .tint(Color.GrayScale.black.color)
            }
            Spacer()
            Text("Transportation").frame(alignment: .center)
            Spacer()
        }
    }
}


// MARK: - Full Screen Card

private extension TransferRecommendView {
    
    @ViewBuilder
    func FullscreenCard(transfertation: Transfertation) -> some View {
        VStack {
            HStack {
                Text(transfertation.name)
                    .font(.system(size: 30.0, weight: .semibold))
                    .frame(alignment: .topLeading)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 14.0, trailing: 0.0))
                Spacer()
            }
            if let image = transfertation.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120.0, height: 120.0)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 42.0, trailing: 0.0))
            }
            HStack {
                Text("다른 사람들은 이렇게 이야기했어요")
                    .font(.system(size: 12.0, weight: .semibold))
                Spacer()
            }
            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
            ForEach(transfertation.tagDatas, id: \.self.id) { tagData in
                GageView(text: tagData.text, backgroundColor: tagData.backgroundColor, percentage: tagData.percentage)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 24.0, leading: 24.0, bottom: 24.0, trailing: 24.0))
    }
    
    @ViewBuilder
    func GageView(text: String, backgroundColor: Color, percentage: CGFloat) -> some View {
        ZStack {
            HStack {
                Rectangle()
                    .fill(Color.GrayScale.white.color)
                    .frame(width: 282.0, height: 40.0, alignment: .leading)
                    .cornerRadius(6.0)
                    .overlay(RoundedRectangle(cornerRadius: 6.0).strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                Spacer()
            }
            
            HStack {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: 282.0 * percentage / 100, height: 40.0, alignment: .leading)
                    .cornerRadius(6.0)
                    .overlay(RoundedRectangle(cornerRadius: 6.0).strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                Spacer()
            }
            HStack {
                Text(text)
                Spacer()
                Text("\(Int(percentage))%")
            }
            .font(.system(size: 12.0, weight: .semibold))
            .padding(EdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 24.0))
        }
    }
}


// MARK: - Sheet Card

private extension TransferRecommendView {
    @ViewBuilder
    func SheetCard(transfertation: Transfertation) -> some View {
        VStack {
            HStack {
                Text(transfertation.name)
                    .font(.system(size: 30.0, weight: .semibold))
                    .frame(alignment: .topLeading)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 15.0, trailing: 0.0))
                Spacer()
            }
            HStack {
                ForEach(0...2, id: \.self) { tagIndex in
                    Text(transfertation.tagDatas[tagIndex].text)
                        .font(.system(size: 14.0, weight: .semibold))
                        .padding(EdgeInsets(top: 7.0, leading: 9.0, bottom: 7.0, trailing: 9.0))
                        .background(transfertation.tagDatas[tagIndex].backgroundColor)
                        .cornerRadius(7.0)
                }
                .overlay(RoundedRectangle(cornerRadius: 7.0).strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                
                Spacer()
            }
            HStack {
                ForEach(3...3, id: \.self) { tagIndex in
                    Text(transfertation.tagDatas[tagIndex].text)
                        .font(.system(size: 14.0, weight: .semibold))
                        .padding(EdgeInsets(top: 7.0, leading: 9.0, bottom: 7.0, trailing: 9.0))
                        .background(transfertation.tagDatas[tagIndex].backgroundColor)
                        .cornerRadius(7.0)
                }
                .overlay(RoundedRectangle(cornerRadius: 7.0).strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        Text("Travel Time")
                            .font(.system(size: 10.0, weight: .light))
                        Text("\(transfertation.travelMinute)min")
                            .font(.system(size: 12.0, weight: .semibold))
                        Spacer()
                    }
                    HStack {
                        Text("Distance")
                            .font(.system(size: 10.0, weight: .light))
                        Text("\(transfertation.distance / 1000)km")
                            .font(.system(size: 12.0, weight: .semibold))
                        Spacer()
                    }
                    HStack {
                        Text("Price")
                            .font(.system(size: 10.0, weight: .light))
                        Text("\(transfertation.price) won")
                            .font(.system(size: 12.0, weight: .semibold))
                        Spacer()
                    }
                }
                Spacer()
                VStack {
                    Spacer()
                    if let image = transfertation.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40.0, height: 40.0, alignment: .bottomTrailing)
                    }
                }
            }
            
            Spacer()
        }
        .padding(EdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0))
    }
}


struct Transfertation: Hashable,Equatable {
    let name: String
    let travelMinute: Int
    let distance: Int
    let tagDatas: [TagData]
    let price: Int
    let image: UIImage?
}

struct TagData: Hashable, Equatable, Identifiable {
    var id = UUID()
    let text : String
    let backgroundColor: Color
    let percentage: CGFloat
}

let transfertationListData:[Transfertation] = [
    .init(name: "Ferry", travelMinute: 40, distance: 7200, tagDatas: [
        .init(text: "# Savoring", backgroundColor: .Tag.yellow.color,
              percentage: 78.0),
        .init(text: "# Seaview", backgroundColor: .Tag.blue.color,
              percentage: 71.0),
        .init(text: "# Photospot", backgroundColor: .Tag.purple.color,
              percentage: 63.0),
        .init(text: "# Scenary", backgroundColor: .Tag.pink.color,
              percentage: 51.0)
    ], price: 13000, image: UIImage(named: "Ferry")),
    .init(name: "Taxi", travelMinute: 25, distance: 2300, tagDatas: [
        .init(text: "# Fast", backgroundColor: .Tag.yellow.color,
              percentage: 80.0),
        .init(text: "# Sway", backgroundColor: .Tag.purple.color,
              percentage: 62.0),
        .init(text: "# Dynamic", backgroundColor: .Tag.yellow.color,
              percentage: 58.0),
        .init(text: "# Private", backgroundColor: .Tag.purple.color,
              percentage: 43.0)
    ], price: 18000, image: UIImage(named: "Taxi")),
    .init(name: "Bicycle", travelMinute: 30, distance: 1100, tagDatas:
            [
                .init(text: "# Restful", backgroundColor: .Tag.blue.color,
                      percentage: 73.0),
                .init(text: "# LowCost", backgroundColor: .Tag.pink.color,
                      percentage: 52.0),
                .init(text: "# As I please", backgroundColor: .Tag.pink.color,
                      percentage: 44.0),
                .init(text: "# Sturdy Legs", backgroundColor: .Tag.blue.color,
                      percentage: 35.0)
            ], price: 3000, image: UIImage(named: "Bicycle")),
    .init(name: "Bus", travelMinute: 40, distance: 7200, tagDatas: [
        .init(text: "# Scenery", backgroundColor: .Tag.blue.color,
              percentage: 78.0),
        .init(text: "# Seaview", backgroundColor: .Tag.blue.color,
              percentage: 65.0),
        .init(text: "# Savoring", backgroundColor: .Tag.yellow.color,
              percentage: 51.0),
        .init(text: "# Every nooke and cranny", backgroundColor:
                .Tag.purple.color, percentage: 42.0)
    ], price: 13000, image: UIImage(named: "RegularBus")),
    .init(name: "Beach Train", travelMinute: 30, distance: 4800,
          tagDatas: [
            .init(text: "# Urban", backgroundColor: .Tag.purple.color,
                  percentage: 71.0),
            .init(text: "# Unique", backgroundColor: .Tag.yellow.color,
                  percentage: 68.0),
            .init(text: "# Scenery", backgroundColor: .Tag.blue.color,
                  percentage: 65.0),
            .init(text: "# Photospot", backgroundColor: .Tag.purple.color,
                  percentage: 41.0)
          ], price: 12000, image: UIImage(named: "BeachTrain"))
]
