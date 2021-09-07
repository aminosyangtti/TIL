//
//  BubbleView.swift
//  BubbleView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI
import Firebase

var rect = UIScreen.main.bounds
var edges = UIApplication.shared.windows.first?.safeAreaInsets

struct BubbleView: View {
    @ObservedObject var bubblesViewModel: BubblesViewModel
    var text: String
    var color: String
    var username: String
    var likes: Int
    var likedBy: [String]
    var timeStamp: Date
    var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
    let user = Auth.auth().currentUser


    @State private var enlarge = false

    var body: some View {

        VStack(spacing: 10) {
            HStack {
                Text(username)
                    .fontWeight(.semibold)
                Spacer()

                Text(formatter.string(from: timeStamp))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(hex: color))

                Text(text)
                    .lineLimit(3)

                    .multilineTextAlignment(.center)
                    .font(.title3)

                    .padding()
            }.frame(height: 300)
                .onTapGesture(count: 2) {
                    likeUnlike()
                }
//            onTapGesture {
//                self.enlarge.toggle()
//            }
            HStack {
                Image(systemName:
                        likedBy.contains(user!.uid) ? "suit.heart.fill" :
                        "suit.heart")
                    .foregroundColor(Color(hex: color))
                    .onTapGesture {
                       likeUnlike()
                    }
                Text(String(likes))
                
            }
            .animation(.spring())

        }
        .frame(width:  rect.width - 30)
        .animation(.default)

    }
    func likeUnlike() {
        withAnimation(.spring()) {
            if !likedBy.contains(user!.uid) {
                bubblesViewModel.likeBubble(text: text, handler: {})
            } else {
                bubblesViewModel.unlikeBubble(text: text, handler: {})

            }
        }

    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(bubblesViewModel: BubblesViewModel(), text: "Today I learned that Jazz is stadadasdadsasdsasssddasdadadadasdadasdasdasdsadasdasdasdasadtistically the hardest word to guesssdsadasdasdad indsadasdasdasdasdasdasdasdasd hangman", color: color.randomElement()!, username: "@sadada", likes: 99, likedBy: [""], timeStamp: Date())

    }

}
