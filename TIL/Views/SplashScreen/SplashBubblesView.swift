//
//  SplashBubblesView.swift
//  SplashBubblesView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct SplashBubblesView: View {
    @Binding var show: Bool
    var x: [CGFloat] = [0.48, -0.5, 0.17, 0.45, -0.3]
    var y:  [CGFloat] = [-0.35, -0.5, -0.45, 0.49, 0.35]
    var scales: [CGFloat] = [0.5, 0.5, 0.1, 0.8, 0.25]
    var body: some View {
        ZStack{
            GeometryReader { geometry in
            Circle()//the one on the center
                .overlay(Text("Today I Learned")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.largeTitle))
                .padding()
                .foregroundColor(Color(hex: color.randomElement()!))
                .opacity(show ? 1 : 0.1)
                .scaleEffect(show ? 1 : 0)
                .offset(x: 0, y: show ? 0 : geometry.size.height * 0.6)
                .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

                ForEach(0..<self.x.count) { index in
            Circle() //top right
                .padding()
                .foregroundColor(Color(hex: color.randomElement()!))
                .opacity(show ? 1 : 0.1)
                .scaleEffect(show ? scales[index] : 0)
                .offset(x: show ? geometry.size.width * x[index] : 0, y: show ? geometry.size.height * y[index] : 600)
                .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.1).delay(Double.random(in: 0...0.5)))

                }

            }

        }
    }
}

struct SplashBubblesView_Previews: PreviewProvider {
    static var previews: some View {
        SplashBubblesView(show: .constant(true))
    }
}
