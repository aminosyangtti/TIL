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


    @ObservedObject var sessionStore = SessionStore()
    @ObservedObject var usersViewModel = UsersViewModel()
    init() {
        sessionStore.listen()
        usersViewModel.fetchData()
    }
    var body: some View {
        ZStack {

            
            ZStack {
            if !showSplashScreen {

            HomeScreenView()
                    .fullScreenCover(isPresented: $sessionStore.isAnon, content: {SignInView(usersViewModel: usersViewModel)})
            }

            }


            if showSplashScreen {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut) {
                                self.showSplashScreen = false
                            }

                        }

                    }
            }

        }
        .offset(y: -keyboardResponder.currentHeight*0.000001)
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

