//
//  Font+Extension.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 23/03/25.
//

import Foundation
import SwiftUICore
import Kingfisher

enum FontStyle: String {
    case bold = "Poppins-Bold"
    case boldItalic = "Poppins-BoldItalic"
    case italic = "Poppins-Italic"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semiBold = "Poppins-SemiBold"
}

extension Font {
    
    static func customFont(style: FontStyle, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
    
}

extension Text {
    func customButton() -> some View {
        self .frame(width: 100, height: 40)
            .font(.customFont(style: .semiBold, size: 14))
            .foregroundStyle(.buttonText)
            .bold()
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 2)
            }
    }
}
