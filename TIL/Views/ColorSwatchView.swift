//
//  ColorSwatchVIew.swift
//  ColorSwatchVIew
//
//  Created by Vincio on 9/12/21.
//

import SwiftUI

struct ColorSwatchView: View {
    @Binding var selection: String

   var body: some View {


       HStack(spacing: 20) {
           ForEach(colors, id: \.self){ color in

                   ZStack {
                       Circle()
                           .fill(Color(hex: color))
                           .frame(width: 25, height: 25)
                           .onTapGesture(perform: {
                               withAnimation(.default) {
                                   selection = color
                               }
                           })

                       if selection == color {
                           Circle()
                               .stroke(Color(hex: color), lineWidth: 5)
                               .frame(width: 40, height: 40)
                       }

                   }
           }

       }

   }
}

struct ColorSwatchView_Previews: PreviewProvider {
   static var previews: some View {
       ColorSwatchView(selection: .constant(colors[0]))
   }
}
