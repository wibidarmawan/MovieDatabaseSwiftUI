//
//  FontModifier.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 24/03/25.
//

import SwiftUI

struct DefaultFontModifier: ViewModifier {
    let style: FontStyle
    let size: CGFloat
    
    init(style: FontStyle = .regular, size: CGFloat = 16) {
        self.style = style
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .font(.customFont(style: style, size: size))
    }
}

extension View {
    func defaultFont(style: FontStyle = .regular, size: CGFloat = 16) -> some View {
        modifier(DefaultFontModifier(style: style, size: size))
    }
}

// Predefined font styles
extension View {
    func titleFont() -> some View {
        defaultFont(style: .bold, size: 18)
    }
    
    func subtitleFont() -> some View {
        defaultFont(style: .semiBold, size: 16)
    }
    
    func bodyFont() -> some View {
        defaultFont(style: .regular, size: 14)
    }
    
    func captionFont() -> some View {
        defaultFont(style: .regular, size: 12)
    }
} 
