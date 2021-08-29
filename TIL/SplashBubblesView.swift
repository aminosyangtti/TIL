//
//  SplashBubblesView.swift
//  SplashBubblesView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct SplashBubblesView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack{
            GeometryReader { geometry in
            Circle()//the one on the center
                .overlay(Text("Today I Learned")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.largeTitle))
                .padding()
                .foregroundColor(Color(hex: color))
                .opacity(show ? 1 : 0.1)
                .scaleEffect(show ? 1 : 0.2)
                .offset(x: 0, y: show ? 0 : geometry.size.height * 0.6)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

            Circle() //top right
                .padding()
                .foregroundColor(Color(hex: color2))
                .opacity(show ? 1 : 0.1)
                .scaleEffect(show ? 0.5 : 0.0001)
                .offset(x: show ? geometry.size.width * 0.48 : 0, y: show ? -geometry.size.height * 0.35 : 600)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

            Circle() //top left
                .padding()
                .foregroundColor(Color(hex: color3))
                .opacity(show ? 1 : 0.1)
                .scaleEffect(show ? 0.5 : 0.0001)
                .offset(x: show ? -geometry.size.width * 0.5 : 0, y: show ? -geometry.size.height * 0.5 : 600)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

            Circle() // smallest on top
                .padding()
                .foregroundColor(Color(hex: color4))
                .opacity(show ? 1 : 0)
                .scaleEffect(show ? 0.1 : 0.0001)
                .offset(x: show ? geometry.size.width * 0.17 : 0, y: show ? -geometry.size.height * 0.45 : 600)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

            Circle() //bottom right
                .padding()
                .foregroundColor(Color(hex: color5))
                .opacity(show ? 1 : 0)
                .scaleEffect(show ? 0.8 : 0.0001)
                .offset(x: show ? geometry.size.width * 0.45 : 0, y: show ? geometry.size.height * 0.49 : 600)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

            Circle() //bottom left
                .padding()
                .foregroundColor(Color(hex: color6))
                .opacity(show ? 1 : 0)
                .scaleEffect(show ? 0.25 : 0.0001)
                .offset(x: show ? -geometry.size.width * 0.3 : 0, y: show ? geometry.size.height * 0.35 : 600)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))
            }

        }
    }
}

struct SplashBubblesView_Previews: PreviewProvider {
    static var previews: some View {
        SplashBubblesView(show: .constant(true))
    }
}
