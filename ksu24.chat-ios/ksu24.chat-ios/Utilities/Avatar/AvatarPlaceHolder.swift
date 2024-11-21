//
//  PlaceHolder.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct AvatarPlaceHolder: View {
    var letters: String
    
    var body: some View {
       ZStack(alignment: .center) {
            Circle()
               .fill(Color.random())
               .frame(width: 60, height: 60)
           
          
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
