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
    case isSavoring
    case isFast
    case isSway
    case isPrivate
    case isLowCost
    case isUrban
    case isSlowly
    case isRestful
    case isUnique
    case isPhotospot
    case isScnery
    case isDynamic
    case isAsIPlease
    
    var tagStyle: (String, Color) {
        switch self {
        case .isSavoring:
            return ("# Savoring", Color.Tag.yellow.color)
        case .isFast:
            return ("# Fast", Color.Tag.yellow.color)
        case .isSway:
            return ("# Sway", Color.Tag.purple.color)
        case .isPrivate:
            return ("# Private", Color.Tag.purple.color)
        case .isLowCost:
            return ("# LowCost", Color.Tag.pink.color)
        case .isUrban:
            return ("# Urban", Color.Tag.purple.color)
        case .isSlowly:
            return ("# Slowly", Color.Tag.pink.color)
        case .isRestful:
            return ("# Restful", Color.Tag.yellow.color)
        case .isUnique:
            return ("# Unique", Color.Tag.yellow.color)
        case .isPhotospot:
            return ("# Photospot", Color.Tag.purple.color)
        case .isScnery:
            return ("# Scenery", Color.Tag.blue.color)
        case .isDynamic:
            return ("# Dynamic", Color.Tag.yellow.color)
        case .isAsIPlease:
            return ("#As I Please", Color.Tag.pink.color)
        }
    }
}

struct RatingView: View {
    @State var selectedTagCount = 0
    
    let description = "How was your journey?"
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
                    .padding(.bottom, 34)
                
                InfoCard(info: beachTrain)
                    .padding(.bottom, 20)
                
                TagStack(tagCount: $selectedTagCount)
                
                Button {
                } label: {
                    Text(buttonLabel)
                        .foregroundColor(handleButtonText(selectedTagCount))
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(
                            handleButtonStyle(selectedTagCount)
                        )
                }
                .padding(.bottom, 10)
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
    func handleButtonText(_ selectedTagCount: Int) -> Color {
        if selectedTagCount < 1 {
            return Color.GrayScale.gray4.color
        } else {
            return Color.GrayScale.white.color
        }
    }
    
    func handleButtonStyle(_ selectedTagCount: Int) -> some View {
        if selectedTagCount < 1 {
            let rectangle = RoundedRectangle(cornerRadius: buttonRadius)
                .inset(by: 0.5)
                .strokeBorder(Color.GrayScale.gray4.color)
                .background(Color.GrayScale.white.color)
                .cornerRadius(buttonRadius)
            return rectangle
        } else {
            let rectangle = RoundedRectangle(cornerRadius: buttonRadius)
                .inset(by: 0.5)
                .strokeBorder(Color.GrayScale.black.color)
                .background(Color.GrayScale.black.color)
                .cornerRadius(buttonRadius)
            return rectangle
        }
    }
}

struct InfoCard: View {
    let info: Info
    let cardRadius = 12.0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(info.transportation)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.top, 18)
                    .padding(.bottom, 3)
                
                Text("\(info.departure) → \(info.destination)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.bottom, 13)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
                            Text("\(String(format: "%.1f", info.distance))km")
                            Text("\(info.price)won")
                        }
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(info.emoji)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 21)
        }
        .padding(.horizontal, 28)
        .background(
            RoundedRectangle(cornerRadius: cardRadius)
                .inset(by: 0.5)
                .stroke(Color.GrayScale.black.color)
                .background(Color.Primary.light40.color)
        )
        .foregroundColor(Color.GrayScale.black.color)
        .cornerRadius(cardRadius)
    }
}

struct TagStack: View {
    @Binding var tagCount: Int
    
    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                TagBox(tagCount: $tagCount, style: Tags.isSavoring.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isFast.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isPrivate.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                TagBox(tagCount: $tagCount, style: Tags.isSway.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isLowCost.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isUrban.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                TagBox(tagCount: $tagCount, style: Tags.isSlowly.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isRestful.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isUnique.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                TagBox(tagCount: $tagCount, style: Tags.isPhotospot.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isScnery.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 12) {
                TagBox(tagCount: $tagCount, style: Tags.isDynamic.tagStyle)
                TagBox(tagCount: $tagCount, style: Tags.isAsIPlease.tagStyle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

struct TagBox: View {
    @State var isTagSelected = false
    @Binding var tagCount: Int
    
    let tagRadius = 12.0
    let style: (String, Color)
    
    var body: some View {
        Button {
            handleTag(isTagSelected, tagCount)
        } label: {
            HStack {
                Text(style.0)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
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
    func handleTag(_ isTagSelected: Bool, _ tagCount: Int) {
        self.isTagSelected.toggle()
        
        if !isTagSelected {
            self.tagCount += 1
        } else {
            self.tagCount -= 1
        }
        print(tagCount)
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
