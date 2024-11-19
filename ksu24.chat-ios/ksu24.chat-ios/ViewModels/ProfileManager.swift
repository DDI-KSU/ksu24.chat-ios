//
//  ProfileManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 19/11/2024.
//

import SwiftUI
import Combine

class ProfileManager: ObservableObject {
    @Published public var profile: Profile = Profile(id: UUID.init(), name: "", surname: "")
    
    private var NRL:            NetworkResponseLoader
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
    
    public func loadProfile() {
        NRL.loadSingle(modelType: Profile.self, endpoint: .profile, method: "GET")
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { result in
                    self.profile = result
                })
                .store(in: &cancellables)
    }
}
