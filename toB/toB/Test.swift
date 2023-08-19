//
//  Test.swift
//  toB
//
//  Created by 김다빈 on 2023/08/19.
//

import SwiftUI
import NMapsMap

struct Test: View {
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    

    var body: some View {
        ZStack {
            UIMapView(coord: coord)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                PathSelectionBottomSheetView()
                    .frame(alignment: .bottom)
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
