//
//  CustomCarousel.swift
//  toB
//
//  Created by 김수환 on 2023/08/19.
//

import SwiftUI

struct CustomCarousel<Content: View,Item,ID>: View where Item: RandomAccessCollection, ID: Hashable,Item.Element:Equatable {
    var content: (Item.Element,CGSize,Int?)->Content
    var id: KeyPath<Item.Element,ID>
    var spacing: CGFloat
    var cardPadding: CGFloat
    @Binding var index:Int
    var items: Item
    var isFullScreen: Bool
    init(
        index: Binding<Int>,
        items: Item,
        spacing: CGFloat = 30,
        cardPadding: CGFloat = 80,
        id: KeyPath<Item.Element, ID>,
        isFullScreen: Bool,
        @ViewBuilder content: @escaping (Item.Element,CGSize,Int?) -> Content
    ){
        self.content = content
        self.id = id
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
        self.isFullScreen = isFullScreen
    }
    
    //MARK: Gesture Properties
    @GestureState var translation: CGFloat = 0
    @State var offset_XIndex: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing: spacing) {
                ForEach(items, id: id) { val in
                    let index = indexOf(item: val)
                    var contentHeight: CGFloat {
                        guard index == self.index else {
                            return 0
                        }
                        return isFullScreen ? 494.0 : 220.0
                    }
                    content(
                        val,
                        CGSize(width: size.width - cardPadding, height: size.height),
                        self.index == index ? self.index : nil
                    )
                    .frame(width: size.width - cardPadding, height: contentHeight)
                    .contentShape(Rectangle())
                    .background(index == self.index ? Color.Primary.light20.color : Color.gray)
                    .cornerRadius(15.0)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 15.0
                        )
                        .strokeBorder(
                            Color.GrayScale.black.color,
                            lineWidth: 1.0
                        )
                    )
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: limitScroll(), y:0)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 10)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged{onChanged(value: $0, cardWidth: cardWidth)}
                    .onEnded{onEnd(value: $0, cardWidth: cardWidth)}
            )
        }
        .padding(.top, 60)
        .onAppear{
            let extraSpace = (cardPadding / 2) - spacing
            offset_XIndex = extraSpace
            lastStoredOffset = extraSpace
        }
        .animation(.easeOut, value: translation == 0)
    }
    
    func indexOf(item: Item.Element) -> Int {
        let array = Array(items)
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
    }
    
    func limitScroll () -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        if index == 0 &&  offset_XIndex > extraSpace {
            return extraSpace + (offset_XIndex / 4)
        }else if index == items.count - 1 && translation < 0 {
            return offset_XIndex - (translation / 2)
        }else {
            return offset_XIndex
        }
    }
    
    func onChanged(value: DragGesture.Value, cardWidth:CGFloat) {
        let translationX = value.translation.width
        offset_XIndex = translationX + lastStoredOffset
    }
    
    func onEnd(value: DragGesture.Value, cardWidth: CGFloat) {
        var _index = (offset_XIndex / cardWidth).rounded()
        _index = max(-CGFloat(items.count-1), _index)
        _index = min(_index, 0)
        currentIndex = Int(_index)
        index = -currentIndex
        
        withAnimation(.easeOut(duration: 0.25)) {
            let extraSpace = (cardPadding / 2) - spacing
            offset_XIndex = (cardWidth * _index) + extraSpace
        }
        lastStoredOffset = offset_XIndex
    }
}
