//
//  AddButton.swift
//  AddButton
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showAddBubble: Bool
    @ObservedObject var sessionStore = SessionStore()
    @State private var showSignout = false
    
    var body: some View {
        HStack {
            Image(systemName: showSignout ? "arrowshape.turn.up.backward.circle.fill" : "arrowshape.turn.up.backward.circle")

                .onTapGesture {
                    withAnimation(.spring()) {showSignout.toggle()}
                }
            if showSignout {
                Text("Sign Out")
                    .font(Font.custom("Avenir", size: 18).weight(.heavy))
                    .onTapGesture {
                        self.signOut()
                    }
            }

            Spacer()
            VStack {
                Button(action: {
                    withAnimation(.spring()) {
                        showAddBubble.toggle()}}) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color(hex: "222F3E"))
                        .font(.title2)

                        
                }

            }
        }
        .padding(.horizontal, 15)
    }
    func signOut() { //to do: view to call signOut()
        self.sessionStore.signOut()
        self.sessionStore.unbind()
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showAddBubble: .constant(true))
    }
}
