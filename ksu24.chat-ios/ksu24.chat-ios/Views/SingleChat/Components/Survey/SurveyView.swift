//
//  SurveyView.swift
//  ksu24.chat-ios
//
//  Created by Milush Kulpiiev on 04/12/2024.
//

import SwiftUI

struct SurveyView: View {
    @ObservedObject var surveyManager: SurveyManager
    
    var chatID: UUID
    
    @State var selectedOption: Answer? = nil
    
    @State private var questions:   [Question]  = [Question()] // Array to hold questions
    @State private var startDate:   Date        = Date()
    @State private var endDate:     Date        = Date().addingTimeInterval(60 * 60 * 24)
    @State private var isAnonymous: Bool        = false
    @State private var title:       String      = ""
    
    @State var showBack = false
    
    var body: some View {
        ZStack {
            backgroundBlur
            
            TabView {
                ForEach(surveyManager.surveys) { survey in
                    
                    VStack {
                        Text(survey.content)
                            .font(.title)
                        
                        ZStack(alignment: .center) {
                           base
                            
                        surveyBody(survey: survey)
                        }
                    }
                }
                
                FlipView(front: newSurveyFront, back: newSurveyBack, showBack: $showBack)
            }
            .frame(height: UIScreen.main.bounds.height * 0.85)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
    
    private var backgroundBlur: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(Color.white.opacity(0.1))
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(.ultraThinMaterial)
    }
    
    private var newSurveyFront: some View {
        ZStack(alignment: .center) {
            base
            
            Button {
                withAnimation(.linear(duration: 0.5)) {
                    showBack = true
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()

                    .foregroundStyle(.blue)
                    .frame(
                        width: 60,
                        height: 60
                    )
            }
        }
    }
    
    private var newSurveyBack: some View {
        ZStack(alignment: .center) {
            base
            
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        withAnimation(.linear(duration: 0.5)) {
                            showBack = false
                        }
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
                   
                    Spacer()
                    
                    Button {
                        let survey = CreatedSurvey(
                            content: title, start: parseDateToString(date: startDate), end: parseDateToString(date: endDate), is_anonymous: isAnonymous, questions: questions
                        )
                        
                        surveyManager.createSurvey(withID: chatID, body: survey)
                        
                        showBack = false
                    } label: {
                        Text("Submit")
                            .foregroundStyle(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                CreationSurveyForm(
                    questions: $questions, startDate: $startDate, endDate: $endDate, isAnonymous: $isAnonymous, title: $title
                )
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.6)
    }
    
    @ViewBuilder
    private func surveyBody(survey: Survey) -> some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(survey.questions.indices, id: \.self) { index in
                        let question = survey.questions[index]
                        
                        Text("\(index + 1). \(question.content)")
                            .font(.system(size: 18))
                            .bold()
                            .padding(.horizontal)
                            .padding(.top, 10)
//                            .padding(.bottom, 10)
                        //                    .multilineTextAlignment(.leading)
                        //                            .border(.pink)
                            .frame(
                                maxWidth: UIScreen.main.bounds.width * 0.9,
                                alignment: .leading
                            )
                        //                            .border(.blue)
                        
                        VStack(alignment: .leading) {
                            ForEach(question.answers) { answer in
                                RadioButton(tag: answer, selection: $selectedOption, label: answer.content)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                            }
                        }
//                        .offset(x: UIScreen.main.bounds.width * 0.1)
//                        //                        .border(.orange)
                        
                        Divider()
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 1, alignment: .center)
                            .foregroundColor(Color(.systemGray4))
                            .padding(.top, 10)
//                            .border(.blue)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Text("Sumbit Answer")
                        .padding(12)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.vertical)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.6)
    }
    
    private var base: some View {
      RoundedRectangle(cornerRadius: 18)
            .fill(Color(.systemGray5))
            .frame(
                width: UIScreen.main.bounds.width * 0.9,
                height: UIScreen.main.bounds.height * 0.6
            )
    }
}
//#Preview {
//    SurveyView(surveyManager: SurveyManager())
//}
