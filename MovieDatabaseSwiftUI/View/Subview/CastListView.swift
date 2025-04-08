//
//  CastListView.swift
//  MovieDatabaseSwiftUI
//
//  Created by Wibi Darmawan on 24/03/25.
//

import SwiftUI
import Kingfisher

struct CastListView: View {
    let header: String
    @Binding var casts: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.customFont(style: .bold, size: 28))
                .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(casts, id: \.id) { cast in
                        VStack(alignment: .center, spacing: 4) {
                            KFImage.url(URL(string: cast.profilePathUrl))
                                .resizable()
                                .placeholder {
                                    Rectangle()
                                        .foregroundColor(.gray.opacity(0.2))
                                        .overlay(
                                            Image(systemName: "person")
                                                .font(.largeTitle)
                                                .foregroundColor(.gray)
                                        )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .frame(width: 120)
                                .frame(height: 160)
                                .cornerRadius(8)
                            
                            Text(cast.name)
                                .captionFont()
                            Text(cast.character)
                                .captionFont()
                        }
                        .frame(maxWidth: 120)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxHeight: 280)
    }
}
