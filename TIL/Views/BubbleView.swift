//
//  BubbleView.swift
//  BubbleView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct BubbleView: View {
    var text: String
    var color: String

    @State private var enlarge = false

    var size: CGFloat
    var y: CGFloat
    var x: CGFloat
    var body: some View {

        ZStack {
            Circle()


                .foregroundColor(Color(hex: color))
            Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
                .padding()
                .font(enlarge ? .title : .title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(enlarge ? .none : 3)
                .scaleEffect(0.5)

        }
        .scaleEffect(enlarge ? size * 2 : size)
        .offset(x:  x, y: y)

        
        


        .onTapGesture(count: 2) {print("Double tapped!")}
        .onTapGesture {
            withAnimation(.spring()) {
            self.enlarge.toggle()
            }
        }


            
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(text: "Today I learned that Jazz is stadadasdadsasdsasssddasdadadadasdadasdasdasdsadasdasdasdasadtistically the hardest word to guesssdsadasdasdad indsadasdasdasdasdasdasdasdasd hangman", color: color.randomElement()!, size: 1, y: 0, x:  0)
    }
}
