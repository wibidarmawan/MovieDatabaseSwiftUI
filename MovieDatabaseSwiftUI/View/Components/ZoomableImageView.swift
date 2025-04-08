//
//  ZoomableImageView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 25/03/25.
//

import SwiftUI
import Kingfisher

struct ZoomableImageView: View {
    let imageURL: String
    let title: String
    var placeholder: AnyView? = nil
    var cornerRadius: CGFloat = 0
    var showExpandIcon: Bool = true
    var frameSize: CGSize? = nil
    
    @State private var isShowingFullScreen = false
    
    var body: some View {
        Button {
            isShowingFullScreen = true
        } label: {
            KFImage.url(URL(string: imageURL))
                .resizable()
                .placeholder {
                    if let placeholder = placeholder {
                        placeholder
                    } else {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                    }
                }
                .applyIf(frameSize != nil) { view in
                    view.frame(width: frameSize?.width, height: frameSize?.height)
                }
                .applyIf(cornerRadius > 0) { view in
                    view.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                }
                .applyIf(showExpandIcon) { view in
                    view.overlay(
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.caption)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                            .padding(8),
                        alignment: .bottomTrailing
                    )
                }
        }
        .buttonStyle(PlainButtonStyle())
        .fullScreenCover(isPresented: $isShowingFullScreen) {
            FullScreenImageView(
                imageURL: imageURL,
                title: title
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Poster-style image
        ZoomableImageView(
            imageURL: "https://image.tmdb.org/t/p/w500/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg",
            title: "Inception",
            cornerRadius: 8,
            frameSize: CGSize(width: 120, height: 200)
        )
        
        // Backdrop-style image
        ZoomableImageView(
            imageURL: "https://image.tmdb.org/t/p/original/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg",
            title: "Inception",
            showExpandIcon: false
        )
    }
    .padding()
} 
