//
//  FullScreenImageView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 25/03/25.
//

import SwiftUI
import Kingfisher

struct FullScreenImageView: View {
    @Environment(\.dismiss) private var dismiss
    let imageURL: String
    let title: String
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .padding(12)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        // Reset zoom and position
                        scale = 1.0
                        offset = .zero
                        lastOffset = .zero
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.headline)
                            .padding(12)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                .padding()
                .foregroundColor(.white)
                
                Spacer()
                
                KFImage.url(URL(string: imageURL))
                    .resizable()
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Update offset in real-time as finger moves
                                offset = CGSize(
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { value in
                                // Save the final position when gesture ends
                                lastOffset = offset
                            }
                    )
                    .simultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / lastScale
                                lastScale = value
                                
                                // Limit zoom scale between 0.5 and 4
                                scale = min(max(scale * delta, 0.5), 4.0)
                            }
                            .onEnded { _ in
                                lastScale = 1.0
                            }
                    )
                    .simultaneousGesture(
                        TapGesture(count: 2)
                            .onEnded {
                                if scale > 1.0 {
                                    // Reset to normal size
                                    withAnimation {
                                        scale = 1.0
                                        offset = .zero
                                        lastOffset = .zero
                                    }
                                } else {
                                    // Zoom in
                                    withAnimation {
                                        scale = 2.0
                                    }
                                }
                            }
                    )
                
                Spacer()
            }
        }
        .statusBar(hidden: true)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    FullScreenImageView(
        imageURL: "https://image.tmdb.org/t/p/original/8IB2e4r4oVhHnANbnm7O3Tj6tF8.jpg",
        title: "Inception"
    )
} 
