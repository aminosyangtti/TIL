//
//  AddButton.swift
//  AddButton
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct AddButton: View {
    @Binding var showAddBubble: Bool
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {withAnimation(.spring()) {showAddBubble.toggle()}}) {
                    Image(systemName: "plus")
                        .foregroundColor(Color(hex: "222F3E"))
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(showAddBubble: .constant(true))
    }
}
