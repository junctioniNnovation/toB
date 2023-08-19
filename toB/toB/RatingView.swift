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
            return ("#exciting", Color.Tag.purple.color)
        }
    }
}

struct RatingView: View {
    @State var selectedTagCount = 0
    
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
                    .padding(.bottom, 31)
                
                InfoCard(info: beachTrain)
                    .padding(.bottom, 20)
                
                TagStack(tagCount: $selectedTagCount)
                
                Button {
                } label: {
                    Text(buttonLabel)
                        .foregroundColor(handleButtonStyle(selectedTagCount).1)
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 130.5)
                        .background(
                            RoundedRectangle(cornerRadius: buttonRadius)
                                .fill(handleButtonStyle(selectedTagCount).0)
                        )
                }
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
    
    func handleButtonStyle(_ selectedTagCount: Int) -> (Color, Color) {
        if selectedTagCount < 1 {
            return (Color.GrayScale.white.color, Color.GrayScale.gray4.color)
        } else {
            return (Color.GrayScale.black.color, Color.GrayScale.white.color)
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
                            Text("\(String(format: "%.1f", info.distance))min")
                            Text("\(info.price)min")
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
        VStack {
            HStack {
                TagBox(tagCount: $tagCount, style: Tags.exciting.tagStyle)
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
