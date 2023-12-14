//
//  View.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import SwiftUI

struct AddBoldAndBlackText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .foregroundStyle(Color.black)
    }
}

extension View {
    func withBlackAndBoldText () -> some View {
       return self.modifier(AddBoldAndBlackText())
    }
    
    func placeholder<Content: View>(
        ifTrue placeHolderShouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(placeHolderShouldShow ? 1 : 0)
            self
        }
    }
}
