//
//  ProfileInfo.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 11/12/2024.
//

import SwiftUI

struct ProfileInfo: View {
    @ObservedObject public var profileManager: ProfileManager
    
    var body: some View {
        VStack {
            avatar(from: profileManager.profile.image)
            initials(
                     name:     profileManager.profile.name, 
                     surname:  profileManager.profile.surname
            )
                .padding(.bottom, 0.5)
            userEmail(profileManager.profile.email)
        }
    }
    
    @ViewBuilder
    private func avatar(from image: String?) ->  some View {
        let initials = profileManager.profile.name + " " + profileManager.profile.surname
        
        if let urlString = image, let url = URL(string: urlString) {
            AsyncWebImage(
                url: url,
                placeholder: AvatarPlaceHolder(letters: initials.takeLettersForAvatar(), frameSize: 80),
                size: 80
            )
        } else {
            AvatarPlaceHolder(letters: initials.takeLettersForAvatar(), frameSize: 80)
        }
    }
    
    @ViewBuilder
    private func initials(name: String, surname: String) -> some View {
        Text("\(name) \(surname)")
            .font(.title)
            .bold()
            
    }
    
    @ViewBuilder
    private func userEmail(_ email: String) -> some View {
        Text(email)
            .foregroundStyle(Color(.systemGray))
            .font(.caption)
//            .padding(.vertical, 0.5)
    }
}

//#Preview {
//    ProfileInfo()
//}
