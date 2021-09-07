//
//  SplashScreen.swift
//  SplashScreen
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

var color = ["75BF97", "A77EBF", "76BF6B", "BF6158", "AFBF62", "7E9CBF"].shuffled()


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
