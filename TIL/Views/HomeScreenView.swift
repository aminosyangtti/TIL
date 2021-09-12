//
//  HomeScreenView.swift
//  TIL
//
//  Created by Vincio on 9/7/21.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var showAddBubble = false
    @ObservedObject var bubblesViewModel  = BubblesViewModel()
    @ObservedObject var usersViewModel = UsersViewModel()
    @State private var isHomeTapped = false
    init() {
        bubblesViewModel.fetchData()
        usersViewModel.fetchData()
    }

    var body: some View {
        ZStack {
            VStack {
                HeaderView(showAddBubble: $showAddBubble, isHomeTapped: $isHomeTapped)
                    .padding(.vertical, 15)
                BubblesContentView(bubblesViewModel: bubblesViewModel, isHomeTapped: $isHomeTapped)
            }
            .dimView($showAddBubble)


            if showAddBubble {
                AddTILBubbleView(showAddBubble: $showAddBubble, bubblesViewModel: bubblesViewModel, usersViewModel: usersViewModel, isHomeTapped: $isHomeTapped)
                    .cornerRadius(24)
                    .padding(25)
                    .transition(.scale)
            }
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                print("DEBUG: \(bubblesViewModel.bubbles)")
            }
           })
        .preferredColorScheme(.light)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
