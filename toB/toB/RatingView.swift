//
//  RatingView.swift
//  toB
//
//  Created by Nayeon Kim on 2023/08/19.
//

import SwiftUI

struct Info {
    let transportation: String
    let departure: String
    let destination: String
    let duration: Int
    let distance: Double
    let price: Int
    let emoji: String
}

struct RatingView: View {
    @State var isRated = false
    let description = "How was this journey \nfor you?"
    let buttonLabel = "Complete"
    
    let beachTrain = Info(transportation: "Beach Train", departure: "Mipo Port", destination: "Songjeong Station", duration: 30, distance: 4.6, price: 16000, emoji: "🚞")
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(description)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                
                InfoCard(info: beachTrain)
                    .padding(.bottom, 12)
                
                //TODO: 스와이프 애니메이션 추가
                HStack {
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                    Image(systemName: "star.fill")
                }
                .font(.system(size: 40))
                .foregroundColor(Color.GrayScale.gray5.color)
                
                Button {
                    
                } label: {
                    HStack {
                        ZStack {
                            Color.Primary.main.color
                            Text(buttonLabel)
                                .foregroundColor(Color.GrayScale.white.color)
                                .fontWeight(.semibold)
                                .padding(.vertical, 15)
                        }
                        .cornerRadius(16.0)
                        .padding(.vertical, 0)
                    }
                }
                .padding(.top, 85)
                .padding(.bottom, 60)
            }
            .padding(.horizontal, 24)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                    }
                }
            }
            
        }
    }
    func handleButton() {
        //TODO: 버튼 활성화
    }
}

struct InfoCard: View {
    let info: Info
    let cardRadius: CGFloat = 12
    
    var body: some View {
        ZStack {
            Color.Primary.light.color
                .opacity(0.2)
            VStack {
                VStack(alignment: .leading) {
                    Text(info.transportation)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color.Primary.main.color)
                        .padding(.bottom, 10)
                    
                    Text("\(info.departure) → \(info.destination)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                //TODO: 간격 조정
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Travel Time")
                            .font(.system(size: 10))
                        
                        Text("\(info.duration)min")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("Distance")
                            .font(.system(size: 10))
                        Text("\(String(format: "%.1f", info.distance))min")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("Price")
                            .font(.system(size: 10))
                        Text("\(info.price)min")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                Text(info.emoji)
                    .font(.system(size: 150))
                    .fontWeight(.bold)
            }
//            .padding(.horizontal, 30)
        }
        .frame(width: 342, height: 373)
        .cornerRadius(cardRadius)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
