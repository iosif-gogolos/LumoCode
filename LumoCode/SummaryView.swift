//
//  SummaryView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct SummaryView: View {
    let score: Int
    let total: Int
    
    var body: some View{
        VStack(spacing: 20){
            Text("🎉 Zusammenfassung")
                .font(.largeTitle)
                .bold()
            
            Text("Du hast \(score) von \(total) Fragen richtig beantwortet!")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            if score == total {
                Text("Perfekt! 🦊✨")
                    .font(.headline)
                    .foregroundColor(.green)
            }else {
                Text("Übung macht den Meister 💪")
                    .font(.headline)
                    .foregroundColor(.orange)
            }
            
            NavigationLink("Nochmal spielen"){
                QuizView(quiz: QuizState(questions: sampleQuestions))
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            
            Spacer()
        }
        .padding()
        
    }
}
