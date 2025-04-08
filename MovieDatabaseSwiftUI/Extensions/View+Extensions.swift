//
//  View+Extensions.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 04/04/25.
//

import Foundation
import SwiftUI

// Conditional view modifier
extension View {
    @ViewBuilder func applyIf<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func applyIfLet<T, Content: View>(_ optional: T?, transform: (Self, T) -> Content) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }
}
