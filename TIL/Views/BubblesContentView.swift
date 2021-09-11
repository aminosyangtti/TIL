//
//  BubblesContentView.swift
//  BubblesContentView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI


struct BubblesContentView: View {
    @ObservedObject var bubblesViewModel: BubblesViewModel
    @State private var isMostPopular = false
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(spacing: 25) {

                HStack {
                    Text(isMostPopular ? "Most Popular" : "Most Recent")
                        .onTapGesture {
                            isMostPopular.toggle()
                        }
                    .font(.footnote)
                    .foregroundColor(.blue)
                    Spacer()
                }
                .frame(width:  rect.width - 30)

                ForEach(isMostPopular ? bubblesViewModel.bubbles.sorted{$0.likes > $1.likes} : bubblesViewModel.bubbles, id: \.id) { bubble in
                    BubbleView(bubblesViewModel: bubblesViewModel, text: bubble.text, color: bubble.color, username: "@\(bubble.createdBy)", likes: bubble.likes, likedBy: bubble.likedBy, timeStamp: bubble.timeStamp)

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


