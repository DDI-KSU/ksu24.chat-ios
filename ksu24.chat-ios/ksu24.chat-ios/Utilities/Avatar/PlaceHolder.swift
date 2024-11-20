//
//  PlaceHolder.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 20/11/2024.
//

import SwiftUI

struct PlaceHolder: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
               .resizable()
               .scaledToFill()
               .frame(width: 60, height: 60)
               .foregroundStyle(Color(.systemGray2))
   }
}


#Preview {
    PlaceHolder()
}
