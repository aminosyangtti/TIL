//
//  AddTILBubbleView.swift
//  AddTILBubbleView
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI
import Firebase

struct AddTILBubbleView: View {
    static var text: String = ""
    static var textBinding = Binding<String>(get: { text }, set: { text = $0.trimmingCharacters(in: .whitespacesAndNewlines) } )
    @State private var isFirstResponder: Bool? = false
    let user = Auth.auth().currentUser
    @Binding var showAddBubble: Bool
    @ObservedObject var bubblesViewModel: BubblesViewModel
    @ObservedObject var usersViewModel: UsersViewModel
    @State private var selection = colors[0]
    @Binding var isHomeTapped: Bool

    var body: some View {
        VStack {
            Text("What did you learn today?")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 15)
            ColorSwatchView(selection: $selection)
                .padding(.bottom, 15)
            MultilineTextField(shouldShowPlaceholder: State<Bool>(initialValue: AddTILBubbleView.text.isEmpty), "Today, I learned...", nextResponder: $isFirstResponder, isResponder: $isFirstResponder, keyboard: .default, text: AddTILBubbleView.textBinding)
                .background(lightGreyColor)

                .cornerRadius(10.0)
                .padding(.bottom, 15)
                .preferredColorScheme(.light)



                Button(action: share) {
                    Text("Share")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                        .font(.body)
                        .foregroundColor(.white)
                        .background(Color(hex: "222F3E"))
                        .cornerRadius(20)
                }

        }
        .padding()
        .background(Color.white)

        .preferredColorScheme(.light)

    }
    func share() {

        if !AddTILBubbleView.text.isEmpty {

            for userID in usersViewModel.users {
                if userID.uid == self.user!.uid {
                    bubblesViewModel.createBubble(text: AddTILBubbleView.text, username: userID.username, color: selection, handler: {})
                    AddTILBubbleView.text = ""
                    self.isHomeTapped.toggle()
                }
            }


            self.showAddBubble = false
        }
    }
}

struct AddTILBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        AddTILBubbleView(showAddBubble: .constant(true), bubblesViewModel: BubblesViewModel(), usersViewModel: UsersViewModel(), isHomeTapped: .constant(false))
    }
}
