//
//  PathSelectionBottomSheetView.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct PathSelectionBottomSheetView: View {
    
    @State var numberOfPerson = 1
    var body: some View {
        ZStack {
            Color.background
            VStack {
                VStack(spacing: 0) {
                    HStack() {
                        Text("Number of Travelers")
                            .font(.system(size: 19.0, weight: .semibold))
                            .frame(alignment: .leading)
                        Spacer()
                        NumberOfPersonButton()
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
                Spacer()
                Button {
                    
                } label: {
                    ZStack {
                        Color.Primary.main.color
                        Text("Continue")
                            .foregroundColor(Color.GrayScale.white.color)
                    }.frame(width: UIScreen.main.bounds.width - 36.0, height: 50.0)
                        .cornerRadius(16.0)
                        .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 60.0, trailing: 0.0))
                        
                }

            }
        }
        .cornerRadius(12.0, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .frame(height: 200.0)
    }
}


// MARK: - Button

private extension PathSelectionBottomSheetView {
    
    @ViewBuilder
    func NumberOfPersonButton() -> some View {
        HStack {
            Button {
                guard numberOfPerson > 1 else { return }
                numberOfPerson -= 1
            } label: {
                Text("-")
                    .foregroundColor(numberOfPerson > 1 ? Color.GrayScale.gray3.color : Color.GrayScale.gray5.color)
            }
            .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 0.0))
            Spacer()
            Text("\(numberOfPerson)")
            Spacer()
            Button {
                guard numberOfPerson < 10 else { return }
                numberOfPerson += 1
            } label: {
                Text("+")
                    .foregroundColor(numberOfPerson < 10 ? Color.GrayScale.gray3.color : Color.GrayScale.gray5.color)
            }.padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 10.0))
        }
        .frame(width: 95.0, height: 31.0)
        .background(Color.GrayScale.gray6.color)
        .cornerRadius(7.0)
    }
}
