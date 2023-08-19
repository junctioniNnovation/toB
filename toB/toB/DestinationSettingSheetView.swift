//
//  DestinationSettingSheetView.swift
//  toB
//
//  Created by Nayeon Kim on 2023/08/19.
//

import SwiftUI

struct DestinationSettingSheetView: View {
    let place = "Darijip"
    let description = "Korean Cuisine"
    let distance = String(3.9) + "km"
    
    let buttonLabel = "Set as Destination"
    
    var body: some View {
        ZStack {
            Color.background
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(place)
                        .fontWeight(.medium)
                    Text(description)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color.GrayScale.gray4.color)
                    Text(distance)
                        .font(.system(size: 13))
                        .foregroundColor(Color.GrayScale.gray3.color)
                }
                .padding(.horizontal, 10)
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                //TODO: 버튼 패딩 수정
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
                .padding(.bottom, 60)
            }
            .padding(.horizontal, 20)
        }
        .cornerRadius(12.0, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .frame(height: 218)
    }
}

struct DestinationSettingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationSettingSheetView()
    }
}
