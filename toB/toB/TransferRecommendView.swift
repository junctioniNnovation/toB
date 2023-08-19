//
//  TransferRecommendView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct TransferRecommendView: View {
    @State var Ontab: Bool = false
    @State var background: Color = .clear
    @State var currentIndex: Int = 0
    @State private var shouldTransition = true
    @Binding var isScreenUp: Bool
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
                // Custom Carousel
                CustomCarousel(
                    index: $currentIndex,
                    items: transfertationList,
                    spacing: UIScreen.main.bounds.width / 3,
                    cardPadding: 48.0,
                    id: \.self,
                    isFullScreen: isFullScreen
                ){ transfertation, _, _ in
                    if isFullScreen {
                        FullscreenCard(transfertation: transfertation)
                    } else {
                        
                    }
                }
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: isFullScreen ? 53.0 : 37.0, trailing: 0.0))
                HStack {
                    Button {
                        // TODO: -
                    } label: {
                        Circle()
                            .overlay(Circle().fill(Color.GrayScale.gray5.color))
                            .overlay(Circle().strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0))
                            .overlay(Image("Xmark"))
                            .frame(width: 66.0, height: 66.0)
                    }
                    Spacer()
                    Button {
                        // TODO: -
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

// MARK: - FullscreenCard

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
            GageView(text: "123", backgroundColor: .red, percentage: 40.0) // TODO: -
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


struct Transfertation: Hashable,Equatable {
    let name:String
    let travelTime:Int
    let distance:Int
    let price:Int
    let image:UIImage?
}

let transfertationList:[Transfertation] = [
    .init(name: "Ferry", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "Ferry")),
    .init(name: "Taxi", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "Taxi")),
    .init(name: "City Tour Bus", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "CityTourBus")),
    .init(name: "Bicycle", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "Bicycle")),
    .init(name: "Regular Bus", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "RegularBus")),
    .init(name: "Monorail", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "Monorail")),
    .init(name: "Beach Train", travelTime: 40, distance: 7200, price: 13000, image: UIImage(named: "BeachTrain"))
]
