//
//  ContentView.swift
//  TIL
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    @ObservedObject var keyboardResponder = KeyboardResponder()
    var body: some View {
        ZStack {
            AddTILBubbleView()
                .cornerRadius(24)
                .padding(50)

            if showSplashScreen {
                SplashScreen().onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut) {
                        self.showSplashScreen = false
                        }
                    }
                }
            }
        }
        .offset(y: -keyboardResponder.currentHeight*0.01)

        .preferredColorScheme(.light)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
