//
//  DimViewModifier.swift
//  DimViewModifier
//
//  Created by Vincio on 8/29/21.
//

import SwiftUI

struct DimViewModifier: ViewModifier {
    @Binding var dim: Bool

    func body(content: Content) -> some View {
        content
            .overlay(Rectangle()
                        .foregroundColor(dim ? .gray.opacity(0.5): .clear)
                        .ignoresSafeArea()
                        .onTapGesture {
                withAnimation(.spring()) {
                    self.dim = false
                }
            })
    }
}

extension View {
    func dimView(_ binding: Binding<Bool>) -> some View {
        self.modifier(DimViewModifier(dim: binding))
    }
}

