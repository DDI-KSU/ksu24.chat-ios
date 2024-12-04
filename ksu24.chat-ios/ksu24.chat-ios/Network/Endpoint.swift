//
//  Endpoint.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation

struct Endpoint {
    var path:       String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    func makeRequest<RequestBody: Codable> (
        withMethod method:  String,
        withBody   body:    RequestBody? = ""
    ) -> URLRequest? {
        
        var components = URLComponents()
        
        components.scheme       =   "https"
        components.host         =   "ksu24.kspu.edu"
        components.path         =   "/" + path
        components.queryItems   =   queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod  = method
        
        if let body = body {
            if let bodyString = body as? String, bodyString.isEmpty {
                
            } else {
                do {
                    request.httpBody = try JSONEncoder().encode(body)
        
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                } catch {
                    print("Failed to encode request body: \(error)")
                    return nil
                }
            }
        }
        
        return request
    }
}

extension Endpoint {
    static var login: Self {
        Endpoint(path: "api/v2/login/")
    }
    
    static var logout: Self {
        Endpoint(path: "api/v2/logout/")
    }
    
    static var conversations: Self {
        Endpoint(path: "api/v2/my/chat/conversations")
    }
    
    static var profile: Self {
        Endpoint(path: "api/v2/my/profile/")
    }
    
    static func messages(withID id: Chat.ID) -> Self {
        Endpoint(path: "api/v2/my/chat/conversations/\(id)/messages")
    }
    
    static func members(withID id: Chat.ID) -> Self {
        Endpoint(path: "api/v2/my/chat/conversations/\(id)/members")
    }
    
    static func surveys(withID id: Chat.ID) -> Self {
        Endpoint(path: "/api/v2/my/chat/conversations/\(id)/surveys/")
    }
}
