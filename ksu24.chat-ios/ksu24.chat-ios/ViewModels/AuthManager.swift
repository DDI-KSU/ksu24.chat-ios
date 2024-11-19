//
//  AuthManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 18/11/2024.
//

import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    private var NRL:            NetworkResponseLoader<User>
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
    
    public func login(creditinals: Credentials) -> User {
        var user: User = .init(access: .init(), refresh: .init())
        
        NRL.loadSingle(endpoint: .login, method: "POST", body: creditinals)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { result in
                    user = result
                })
                .store(in: &cancellables)
        
        return user
    }
}
