//
//  BubblesContentView.swift
//  BubblesContentView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI


struct BubblesContentView: View {
    @State private var isPresent = false
    var rows = [GridItem(.flexible())]


    var body: some View {
        ScrollView (.horizontal){
//            LazyHGrid(rows: rows, spacing: 1) {
            GridStack(rows: 4, columns: 2) {_,_ in
                ForEach(0..<15) { item in
                    BubbleView(text: "asbdasbdakbdsajkbdajk", color: color.randomElement()!, size: isPresent ? CGFloat.random(in: 0.5...1.5) : 0, y: 0, x: CGFloat.random(in: -100...100))
                        .transition(.scale)
                        .animation(.spring())

                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPresent = true
            }
        }
    }
}

struct BubblesContentView_Previews: PreviewProvider {
    static var previews: some View {
        BubblesContentView()
    }
}


