//
//  TILApp.swift
//  TIL
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

@main
struct TILApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.light)
        }
    }
}
