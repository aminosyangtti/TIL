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

    var body: some View {
        VStack {
            Text("What did you learn today?")
                .font(.title)
                .fontWeight(.bold)
            

            MultilineTextField(shouldShowPlaceholder: State<Bool>(initialValue: AddTILBubbleView.text.isEmpty), "Today, I learned...", nextResponder: $isFirstResponder, isResponder: $isFirstResponder, keyboard: .default, text: AddTILBubbleView.textBinding)
                .background(VisualEffectView(style: .systemMaterialLight).opacity(0.3))
                .cornerRadius(10.0)


            ZStack {
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
        }
        .padding()
        .background( VisualEffectView(style:  .systemUltraThinMaterialDark).opacity(1))
        .onAppear(perform: {print("DEBUG: \(usersViewModel.users)")})

    }
    func share() {

        if !AddTILBubbleView.text.isEmpty {

            for userID in usersViewModel.users {
                if userID.uid == self.user!.uid {
                    bubblesViewModel.createBubble(text: AddTILBubbleView.text, username: userID.username, handler: {})
                }
            }


            self.showAddBubble = false
        }
    }
}

struct AddTILBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        AddTILBubbleView(showAddBubble: .constant(true), bubblesViewModel: BubblesViewModel(), usersViewModel: UsersViewModel())
    }
}
