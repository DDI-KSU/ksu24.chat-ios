//
//  SurveysManager.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 04/12/2024.
//

import Foundation
import Combine

class SurveyManager: ObservableObject {
    @Published var surveys: [Survey] = []
    var totalSurveys: Int = 0
    
    private var NRL:            NetworkResponseLoader
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.NRL = .init()
    }
    
    public func loadSurveys(withID: UUID) {
        NRL.loadCollactable(modelType: Survey.self, endpoint: .surveys(withID: withID), method: "GET")
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { ns in
                    self.surveys = ns.results
                    self.totalSurveys = ns.count
                    
                    print(ns)
                })
            .store(in: &cancellables)
                
    }
    
    public func createSurvey(withID: UUID, body: CreatedSurvey) {
        NRL.loadVoid(endpoint: .createSurvey(withID: withID), method: "POST", body: body)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Login failed: \(error)")
                    }
                },
                receiveValue: { ns in
                    print(ns)
                })
            .store(in: &cancellables)
    }
}
