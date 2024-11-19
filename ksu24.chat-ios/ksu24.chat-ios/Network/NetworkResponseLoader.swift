//
//  ResponseLoader.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 17/11/2024.
//

import Foundation
import Combine

struct NetworkResponseLoader {
    var urlSession = URLSession.shared
    
    func loadCollactable<Model: Codable, RequestBody: Codable>(
        modelType: Model.Type,
        endpoint:   Endpoint,
        method:     String,
        body:       RequestBody? = ""
    ) -> AnyPublisher<[Model], Error> {
        
        urlSession.collactablePublisher(for: endpoint.makeRequest(
            withMethod: method,
            withBody: body
        ))
    }
    
    func loadSingle<Model: Codable, RequestBody: Codable>(
        modelType: Model.Type,
        endpoint:   Endpoint,
        method:     String,
        body:       RequestBody? = ""
    ) -> AnyPublisher<Model, Error> {
        
        urlSession.singlePublisher(for: endpoint.makeRequest(
            withMethod: method,
            withBody: body
        ))
    }
        
    func loadVoid<RequestBody: Codable>(
        endpoint:   Endpoint,
        method:     String,
        body:       RequestBody? = ""
    ) -> AnyPublisher<Void, Error> {
        
        urlSession.voidPublisher(for: endpoint.makeRequest(
            withMethod: method,
            withBody: body
        ))
    }
}

extension URLSession {
    
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
    
    func singlePublisher<T: Codable>(
        for     request: URLRequest?,
        decoder:         JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        
        
        guard let request = request else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return dataTaskPublisher(for: request)
                    .map(\.data)
                    .decode(type: T.self, decoder: decoder)
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
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }

                // Print the raw response data as a string
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw Response: \(responseString)")
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...500).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return () // Emit a Void value
            }
            .eraseToAnyPublisher()
    }
}
