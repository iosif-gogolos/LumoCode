//
//  QuizView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct QuizView: View {
    @StateObject var quiz: QuizState
    let categoryTitle: String
    
    @Binding var userName: String
    @Binding var selectedCategory: QuizCategory?
    @Binding var showQuiz: Bool
    
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var isCorrect: Bool = false
    @State private var lumoScale: CGFloat = 1.0
    @State private var showSummary: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            VStack(spacing: 8) {
                HStack {
                    Text(categoryTitle)
                        .font(.headline)
                        .bold()
                    Spacer()
                    Text("\(quiz.currentIndex + 1)/\(quiz.questions.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                ProgressView(value: quiz.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                    .scaleEffect(y: 2)
            }
            .padding()
            .background(Color(.systemBackground))
            
            ScrollView {
                VStack(spacing: 30) {
                    Image("LumoExplains")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .scaleEffect(lumoScale)
                        .animation(.bouncy(duration: 0.5), value: lumoScale)
                    
                    Text(quiz.currentQuestion.text)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        ForEach(0..<quiz.currentQuestion.answers.count, id: \.self) { index in
                            AnswerButton(
                                text: quiz.currentQuestion.answers[index],
                                isSelected: selectedAnswer == index,
                                isCorrect: showFeedback && index == quiz.currentQuestion.correctAnswer,
                                isWrong: showFeedback && selectedAnswer == index && index != quiz.currentQuestion.correctAnswer,
                                isDisabled: showFeedback
                            ) {
                                if !showFeedback {
                                    selectAnswer(index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    if showFeedback {
                        VStack(spacing: 15) {
                            Text(LocalizedStringKey(isCorrect ? "correct" : "wrong"))
                                .font(.headline)
                                .foregroundColor(isCorrect ? .green : .red)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(LocalizedStringKey("explanation"))
                                    .font(.headline)
                                Text(quiz.currentQuestion.explanation)
                                    .font(.body)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            
                            Button(LocalizedStringKey("continue")) {
                                nextQuestion()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                        .transition(.opacity.combined(with: .slide))
                    }
                    
                    Spacer(minLength: 50)
                }
            }
            
            // Score Display
            HStack {
                Text(String(format: NSLocalizedString("points", comment: ""), quiz.totalPoints))
                Spacer()
                Text(String(format: NSLocalizedString("streak", comment: ""), quiz.streak))
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        // NavigationDestination muss hier auf der View-Ebene sein
        .navigationDestination(isPresented: $showSummary) {
            SummaryView(
                totalPoints: quiz.totalPoints,
                accuracy: quiz.accuracy,
                bestStreak: quiz.bestStreak,
                totalQuestions: quiz.questions.count,
                userName: $userName,
                selectedCategory: $selectedCategory,
                showQuiz: $showQuiz
            )
        }
    }
    
    private func selectAnswer(_ index: Int) {
        selectedAnswer = index
        isCorrect = quiz.checkAnswer(index)
        
        withAnimation(.bouncy) {
            showFeedback = true
            lumoScale = isCorrect ? 1.3 : 0.8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.bouncy) {
                lumoScale = 1.0
            }
        }
    }
    
    private func nextQuestion() {
        withAnimation {
            showFeedback = false
            selectedAnswer = nil
            if !quiz.nextQuestion() {
                // Zeige SummaryView
                showSummary = true
            }
        }
    }
}



