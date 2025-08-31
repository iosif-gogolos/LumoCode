//
//  QuizView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct QuizView: View{
    @State var quiz: QuizState
    @State private var feedback: String? = nil
    @State private var showSummary = false
    
    var body: some View{
        VStack(spacing: 20){
            Text(quiz.currentQuestion.text)
                .font(.title2)
                .padding()
            
            ForEach(0..<quiz.currentQuestion.answers.count, id: \.self)  {
                index in Button(action: {
                    let result = quiz.checkAnswer(index)
                    feedback = result ? "✅ Richtig!" : "❌Falsch!"
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                        if !quiz.nextQuestion() {
                            showSummary = true
                        }
                        feedback = nil
                    }
                }) {
                    Text(quiz.currentQuestion.answers[index])
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                }
            }
            
            if let fb = feedback {
                Text(fb)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
            }
            
            Spacer()
            
            Text("Score: \(quiz.score) | Streak: \(quiz.streak)")
                .font(.footnote)
        }
        .padding()
        .navigationDestination(isPresented: $showSummary){
            SummaryView(score: quiz.score, total: quiz.questions.count)
        }
    }
}
                    
