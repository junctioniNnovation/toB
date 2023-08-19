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

enum Tags {
    case exciting
    
    var tagStyle: (String, Color) {
        switch self {
        case .exciting:
            return ("#exciting", Color.purple)
        }
    }
}

struct RatingView: View {
    @State var isRated = false
    let description = "How was this journey \nfor you?"
    let buttonLabel = "Complete"
    let buttonRadius = 16.0
    
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
                    .padding(.bottom, 20)
                
                TagStack()

                Button {
                    
                } label: {
                    HStack {
                        ZStack {
                            Color.GrayScale.black.color
                            Text(buttonLabel)
                                .foregroundColor(Color.GrayScale.white.color)
                                .fontWeight(.semibold)
                                .padding(.vertical, 15)
                        }
                        .cornerRadius(buttonRadius)
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
                        Image(systemName: BarItems.rightButton.label)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.GrayScale.black.color)
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
    let cardRadius = 12.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cardRadius)
                .inset(by: 0.5)
                .stroke(Color.GrayScale.black.color)
                .background(Color.Primary.light40.color)
            
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(info.transportation)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    
                    Text("\(info.departure) → \(info.destination)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Travel Time")
                                Text("Distance")
                                Text("Price")
                            }
                            .font(.system(size: 10))
                            .padding(.trailing, 24)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(info.duration)min")
                                Text("\(String(format: "%.1f", info.distance))min")
                                Text("\(info.price)min")
                            }
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    
                    Text(info.emoji)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.trailing, 35)
                }
            }
        }
        .foregroundColor(Color.GrayScale.black.color)
        .frame(width: 342, height: 164)
        .cornerRadius(cardRadius)
    }
}

struct TagStack: View {
    var body: some View {
        VStack {
            HStack {
                Tag(style: Tags.exciting.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
            .frame(maxHeight: .infinity)
    }
}

struct Tag: View {
    @State var isTagSelected = false
    
    let tagRadius = 12.0
    let style: (String, Color)
    
    var body: some View {
        Button {
            handleTag(isTagSelected)
        } label: {
            HStack {
                Text(style.0)
                    .foregroundColor(Color.GrayScale.black.color)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                
            }
            .background(
                RoundedRectangle(cornerRadius: tagRadius)
                .inset(by: 0.5)
                .stroke(Color.GrayScale.black.color)
                .background(handleTagStyle(isTagSelected))
                .cornerRadius(tagRadius))
        }
    }
    func handleTag(_ isTagSelected: Bool) {
        self.isTagSelected.toggle()
    }
    
    func handleTagStyle(_ isTagSelected: Bool) -> Color {
        if isTagSelected {
            return style.1
        } else {
            return Color.GrayScale.gray6.color
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
