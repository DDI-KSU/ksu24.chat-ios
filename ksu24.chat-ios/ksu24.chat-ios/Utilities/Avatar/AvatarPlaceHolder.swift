//
//  PlaceHolder.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AvatarPlaceHolder: View {
    var letters: String
    var frameSize: CGFloat
    
    var body: some View {
       ZStack(alignment: .center) {
            Circle()
               .fill(Color.random())
               .frame(width: frameSize, height: frameSize)
           
          
           Text(letters)
               .font(.headline)
               .foregroundColor(.white)
        }
   }
}

//
//#Preview {
//    AvatarPlaceHolder(chatName: "K")
//}
