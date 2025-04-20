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
    
    private var NRL:            NetworkResponseLoader
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
    
    public func login(creditinals: Credentials) {
        NRL.loadSingle(modelType: Token.self, endpoint: .login, method: "POST", body: creditinals)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { result in
                    print(result)
                })
                .store(in: &cancellables)
    }
    
    public func logout() {
        NRL.loadVoid(endpoint: .logout, method: "POST")
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Logout failed: \(error)")
                    }
                },
                receiveValue: { result in
                    print(result)
                })
                .store(in: &cancellables)
    }
}
