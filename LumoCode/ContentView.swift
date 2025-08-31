//
//  ContentView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var startQuiz = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30){
                Text("🐾 LumoCode")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Lerne Swift spielerisch mit Lumo!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
                Button(action: {
                    startQuiz = true
                }){
                    Text("Anfangen")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .navigationDestination(isPresented: $startQuiz) {
                    QuizView(quiz: QuizState(questions: sampleQuestions))
                }
                
                Spacer()
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
