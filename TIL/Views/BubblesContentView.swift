//
//  BubblesContentView.swift
//  BubblesContentView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI


struct BubblesContentView: View {
    @ObservedObject var bubblesViewModel: BubblesViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            LazyVStack(spacing: 25) {
                ForEach(bubblesViewModel.bubbles, id: \.id) { bubble in
                    BubbleView(bubblesViewModel: bubblesViewModel, text: bubble.text, color: color.randomElement()!, username: "@\(bubble.createdBy)", likes: bubble.likes, likedBy: bubble.likedBy, timeStamp: bubble.timeStamp)

                }
            }

        }

    }

}

struct BubblesContentView_Previews: PreviewProvider {
    static var previews: some View {
        BubblesContentView(bubblesViewModel: BubblesViewModel())
    }
}


