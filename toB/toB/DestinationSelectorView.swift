//
//  DestinationSelectorView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct DestinationSelectorView: View {
    
    @Binding var title: String?
    @State var isPrimary: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .strokeBorder(Color.GrayScale.black.color, lineWidth: 1.0)
                    .background(Circle().foregroundColor(isPrimary ? Color.clear : Color.GrayScale.black.color))
                    .frame(width: 9.0, height: 9.0)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 14.0))
                Text(title ?? "Where is the destination?")
                    .font(.system(size: 19.0, weight: .semibold))
                    .foregroundColor(isPrimary ? Color.GrayScale.black.color : Color.GrayScale.gray4.color)
                Spacer()
            }
            Divider()
                .frame(minHeight: 1)
                .background(Color.GrayScale.gray4.color)
        }.onTapGesture {
            action()
        }
    }
}
