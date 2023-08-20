//
//  Carousel.swift
//  toB
//
//  Created by Nayeon Kim on 2023/08/20.
//

import SwiftUI

struct Carousel: View {
    @State var flag = 0
    var body: some View {
        GeometryReader{ _ in
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<100, id: \.self) { index in
                            let item = transfertationList[index % transfertationList.count]
                            TransportationCard(item: item)
                        }
                    }
                    .onAppear {
                        flag = 40
                        proxy.scrollTo(flag, anchor: .center)
                    }
                }
                .scrollDisabled(true)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width > 0 {
                                if(flag >= 1){
                                    withAnimation(.linear){
                                        flag -= 1
                                        proxy.scrollTo(flag,anchor: .center)
                                        print(flag)
                                    }
                                }
                            }
                            else if value.translation.width < 0 {
                                if(flag < 101){
                                    withAnimation(.linear){
                                        flag += 1
                                        proxy.scrollTo(flag,anchor: .center)
                                        print(flag)
                                    }
                                }
                            }
                        }
                )
            }
        }
    }
}

struct TransportationCard: View {
    let item: Transfertation
    let cardRadius = 12.0
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.vertical, 15)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    TransportationTag(description: "# 한적한")
                    TransportationTag(description: "# 한적한")
                }
                TransportationTag(description: "# 한적한")
            }
            .padding(.bottom, 16)
            
            HStack() {
                VStack(alignment: .leading, spacing: 9) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Travel Time")
                            Text("Distance")
                            Text("Price")
                        }
                        .font(.system(size: 10))
                        .padding(.trailing, 24)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(item.travelMinute)min")
                            Text("\(String(format: "%.1f", item.distance))km")
                            Text("\(item.price) won")
                        }
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                    }
                }
                Spacer(minLength: 124)
                
                Image(item.name)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            .padding(.bottom, 20)
            
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: cardRadius)
                .inset(by: 0.5)
                .stroke(Color.GrayScale.black.color)
                .background(Color.Primary.light20.color)
        )
        .foregroundColor(Color.GrayScale.black.color)
    }
}

struct TransportationTag: View {
    let description: String
    let tagRadius = 7.0
    var body: some View {
        Text("\(description)")
            .font(.system(size: 16))
            .fontWeight(.bold)
            .foregroundColor(Color.GrayScale.black.color)
            .padding(.vertical, 7)
            .padding(.horizontal, 9)
            .background(
                RoundedRectangle(cornerRadius: tagRadius)
                    .inset(by: 0.5)
                    .stroke(Color.GrayScale.black.color)
                    .background(Color.Tag.blue.color)
                    .cornerRadius(tagRadius))
    }
}
