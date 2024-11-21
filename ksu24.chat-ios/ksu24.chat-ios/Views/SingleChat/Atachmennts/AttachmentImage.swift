//
//  AttachmentImage.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AttachmentImage: View {
    var urlString: String
    var withText: String
    
    var baseURLString: String = "https://ksu24.kspu.edu"
    
    var body: some View {
        if let url = URL(string: baseURLString + urlString) {
            VStack {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder while loading
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        // Error loading image
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(withText)
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
        } else {
            // Invalid URL
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .foregroundColor(.gray)
        }
    }
}

//
//#Preview {
//    AttachmentImage()
//}