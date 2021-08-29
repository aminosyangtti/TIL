//
//  ContentView.swift
//  TIL
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    var body: some View {
        ZStack {
            Text("hello world")
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

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
