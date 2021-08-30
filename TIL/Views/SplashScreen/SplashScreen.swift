//
//  SplashScreen.swift
//  SplashScreen
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

var color = ["6DA49A", "CCD39C", "73B3CE", "222F3E", "92A5E6"]


struct SplashScreen: View {
    @State private var show = false


    var body: some View {
        
        SplashBubblesView(show: $show)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                show.toggle()


            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                show.toggle()

            }
        }
        .background(Color(hex: "F3F4F6").ignoresSafeArea())

    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
