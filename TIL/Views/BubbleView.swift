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
        dateFormatter.timeStyle = .long
        return dateFormatter
    }
    let user = Auth.auth().currentUser

    @State private var showDate = false
    @State private var animationAmount: CGFloat = 1


    @State private var enlarge = false

    var body: some View {

        VStack(spacing: 10) {
            HStack {
                Text(username)
                    .fontWeight(.semibold)
                Spacer()

                Text(showDate ? formatter.string(from: timeStamp): timeStamp.timeAgoDisplay())
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        self.showDate.toggle()
                    }
            }
            .frame(width:  rect.width - 30)

            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(hex: color))

                Text(text)
                    .lineLimit(enlarge ? nil : 5)

                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.white)

                    .padding()
            }
            .frame(width:  enlarge ? rect.width : rect.width - 30, height: enlarge ? 600 : 300)


                .onTapGesture(count: 2) {
                    likeUnlike()
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        self.enlarge.toggle()
                    }
            }
            HStack {
                Image(systemName:
                        likedBy.contains(user!.uid) ? "suit.heart.fill" :
                        "suit.heart")
                    .scaleEffect(animationAmount)
                    .foregroundColor( likedBy.contains(user!.uid) ? Color(hex: "C23023") : .black)
                    .onTapGesture {
                       likeUnlike()
                        withAnimation(.spring()) {
                            self.animationAmount += 0.5
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.animationAmount = 1
                            }
                        }
                    }
                Text(String(likes))
                
            }
            .animation(.spring())

        }

        .animation(.default)

    }
    func likeUnlike() {
        withAnimation(.spring()) {
            if !likedBy.contains(user!.uid) {
                bubblesViewModel.likeBubble(text: text, handler: {})
                
            } else {
                bubblesViewModel.unlikeBubble(text: text, handler: {})

            }

            self.animationAmount += 0.8
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animationAmount = 1
            }

        }

    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(bubblesViewModel: BubblesViewModel(), text: "Today I learned that Jazz is stadadasdadsasdsasssddasdadadadasdadasdasdasdsadasdasdasdasadtistically the hardest word to guesssdsadasdasdad indsadasdasdasdasdasdasdasdasd hangman", color: color.randomElement()!, username: "@sadada", likes: 99, likedBy: [""], timeStamp: Date())

    }

}
