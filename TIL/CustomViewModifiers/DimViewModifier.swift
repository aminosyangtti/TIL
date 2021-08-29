//
//  DimViewModifier.swift
//  DimViewModifier
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct DimViewModifier: ViewModifier {
    @Binding var binding: Bool

    func body(content: Content) -> some View {
        content
            .overlay(Rectangle()
                        .foregroundColor(binding ? .gray.opacity(0.3): .clear)
                        .ignoresSafeArea()
                        .onTapGesture {
                withAnimation(.spring()) {
                    self.binding = false
                }
            })
    }
}

extension View {
    func dimView(_ binding: Binding<Bool>) -> some View {
        self.modifier(DimViewModifier(binding: binding))
    }
}

