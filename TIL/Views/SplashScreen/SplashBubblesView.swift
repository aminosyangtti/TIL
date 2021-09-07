//
//  SplashBubblesView.swift
//  SplashBubblesView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct SplashBubblesView: View {
    @Binding var show: Bool
    var x: [CGFloat] = [0, 0.48, -0.5, 0.17, 0.45, -0.3]
    var y:  [CGFloat] = [0, -0.35, -0.5, -0.45, 0.49, 0.35]
    var scales: [CGFloat] = [1, 0.5, 0.5, 0.1, 0.8, 0.25]
    var text = ["Today I Learned", "", "", "", "", ""]
    var body: some View {
        ZStack{
            GeometryReader { geometry in

                ForEach(0..<self.x.count) { index in
                    Circle()
                        .overlay(Text(text[index])
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.largeTitle))
                        .padding()
                        .foregroundColor(Color(hex: color[index]))
                        .opacity(show ? 1 : 0)
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
