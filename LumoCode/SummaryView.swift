//
//  SummaryView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct SummaryView: View {
    let totalPoints: Int
    let accuracy: Double
    let bestStreak: Int
    let totalQuestions: Int
    
    @Binding var userName: String
    @Binding var selectedCategory: QuizCategory?
    @Binding var showQuiz: Bool
    
    @State private var lumoScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Lumo Celebration
            Image("LumoSpeaks")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(lumoScale)
                .onAppear {
                    withAnimation(.bouncy(duration: 1.0).repeatCount(3, autoreverses: false)) {
                        lumoScale = 1.3
                    }
                }
            
            Text(LocalizedStringKey("quiz_completed"))
                .font(.largeTitle)
                .bold()
            
            // Statistik-Karten
            VStack(spacing: 20) {
                StatCard(
                    icon: "⭐",
                    titleKey: "total_points",
                    value: "\(totalPoints)",
                    color: .orange
                )
                
                StatCard(
                    icon: "🎯",
                    titleKey: "accuracy",
                    value: String(format: "%.0f%%", accuracy),
                    color: .green
                )
                
                StatCard(
                    icon: "🔥",
                    titleKey: "best_streak",
                    value: "\(bestStreak)",
                    color: .red
                )
            }
            .padding(.horizontal)
            
            // Motivational Message
            VStack(spacing: 10) {
                if accuracy >= 80 {
                    Text(LocalizedStringKey("excellent"))
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                    Text(LocalizedStringKey("excellent_message"))
                } else if accuracy >= 60 {
                    Text(LocalizedStringKey("good_job"))
                        .font(.title2)
                        .bold()
                        .foregroundColor(.orange)
                    Text(LocalizedStringKey("good_job_message"))
                } else {
                    Text(LocalizedStringKey("practice_makes_perfect"))
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                    Text(LocalizedStringKey("practice_message"))
                }
            }
            .multilineTextAlignment(.center)
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: 15) {
                NavigationLink(LocalizedStringKey("try_again")) {
                    CategorySelectionView(
                        userName: $userName,
                        selectedCategory: $selectedCategory,
                        showQuiz: $showQuiz
                    )
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                
                NavigationLink(LocalizedStringKey("other_category")) {
                    CategorySelectionView(
                        userName: $userName,
                        selectedCategory: $selectedCategory,
                        showQuiz: $showQuiz
                    )
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    
    struct StatCard: View {
        let icon: String
        let titleKey: String // Statt title: String
        let value: String
        let color: Color
        
        var body: some View {
            HStack(spacing: 15) {
                Text(icon)
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(LocalizedStringKey(titleKey)) // Lokalisierter Titel
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(value)
                        .font(.title)
                        .bold()
                        .foregroundColor(color)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}
