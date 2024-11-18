//
//  ResponseLoader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation
import Combine

struct NetworkResponseLoader<Model: Identifiable & Codable> {
    var urlSession = URLSession.shared
    
    func loadCollactable(
        endpoint:   Endpoint,
        method:     String
    ) -> AnyPublisher<[Model], Error> {
        
        urlSession.collactablePublisher(for: endpoint.makeRequest(withMethod: method))
    }
    
    func loadVoid(
        endpoint:   Endpoint,
        method:     String
    ) -> AnyPublisher<Void, Error> {
        
        urlSession.voidPublisher(for: endpoint.makeRequest(withMethod: method))
    }
}

extension URLSession {
    
    // For Network Response
    func collactablePublisher<T: Codable>(
        for     request: URLRequest?,
        decoder:         JSONDecoder = .init()
    ) -> AnyPublisher<[T], Error> {
        
        guard let request = request else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: NetworkResponse<T>.self, decoder: decoder)
                .map(\.results)
                .eraseToAnyPublisher()
    }
    
    func voidPublisher(
        for request: URLRequest?
    ) -> AnyPublisher<Void, Error> {
        
        guard let request = request else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...500).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return () // Emit a Void value
            }
            .eraseToAnyPublisher()
    }
}
