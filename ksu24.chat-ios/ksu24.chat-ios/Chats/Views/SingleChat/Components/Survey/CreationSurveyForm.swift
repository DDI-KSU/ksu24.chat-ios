//
//  CreationSurveyForm.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 09/12/2024.
//

import SwiftUI

struct CreationSurveyForm: View {
    @Binding public var questions: [Question] // Array to hold questions
    @Binding public var startDate: Date
    @Binding public var endDate: Date
    @Binding public var isAnonymous: Bool
    @Binding public var title: String
    
    var body: some View {
        Form {
            titleSection
            questionsSection
            dateSection
            surveySettingsSection
        }
        .scrollContentBackground(.hidden)
    }
}

extension CreationSurveyForm {
    // MARK: - Title Section
    private var titleSection: some View {
        Section("Title") {
            TextField("Survey Title", text: $title)
        }
    }
    // MARK: - Questions Section
    private var questionsSection: some View {
        Section("Questions and Answers") {
            ForEach(questions.indices, id: \.self) { index in
                questionBlock(for: index)
            }
            
            Button(action: addQuestion) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                    Text("Add Question")
                        .foregroundStyle(.black)
                }
            }
        }
    }
    
    private func questionBlock(for index: Int) -> some View {
        VStack(alignment: .leading) {
            TextField("Question \(index + 1)", text: $questions[index].content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ForEach(questions[index].answers.indices, id: \.self) { answerIndex in
                answerBlock(for: index, answerIndex: answerIndex)
            }
            
            Button(action: { addAnswer(to: index) }) {
                HStack {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.blue)
                    Text("Add Answer")
                        .foregroundStyle(.black)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.top, 5)
            
            if questions.count > 1 {
                Button(action: { removeQuestion(at: index) }) {
                    HStack {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                        Text("Remove Question")
                            .foregroundStyle(.black)
                    }
                }
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 10)
    }
    
    private func answerBlock(for questionIndex: Int, answerIndex: Int) -> some View {
        HStack {
            TextField("Answer \(answerIndex + 1)", text: $questions[questionIndex].answers[answerIndex].content)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: { removeAnswer(from: questionIndex, at: answerIndex) }) {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
    
    // MARK: - Date Section
    private var dateSection: some View {
        Section("Date") {
            DatePicker("Start", selection: $startDate, displayedComponents: [.hourAndMinute, .date])
            DatePicker("End", selection: $endDate, displayedComponents: [.hourAndMinute, .date])
        }
    }
    
    // MARK: - Survey Settings Section
    private var surveySettingsSection: some View {
        Section("Survey Settings") {
            Toggle("Anonymous", isOn: $isAnonymous)
        }
    
    }
    
    // MARK: - Helper Methods
    private func addQuestion() {
        questions.append(Question())
    }
    
    private func removeQuestion(at index: Int) {
        questions.remove(at: index)
    }
    
    private func addAnswer(to questionIndex: Int) {
        questions[questionIndex].answers.append(Answer())
    }
    
    private func removeAnswer(from questionIndex: Int, at answerIndex: Int) {
        questions[questionIndex].answers.remove(at: answerIndex)
    }
}


//#Preview {
//    CreationSurveyForm()
//}
