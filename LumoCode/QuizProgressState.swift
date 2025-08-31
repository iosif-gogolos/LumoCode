//
//  QuizProgressState.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct QuizProgressHeader: View {
    let quiz: QuizState
    let categoryTitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(categoryTitle)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.textPrimary)
                Spacer()
                Text("\(quiz.currentIndex + 1)/\(quiz.questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            
            // Custom Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.backgroundCard)
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.lumoPrimary, .lumoSecondary],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * quiz.progress, height: 6)
                        .cornerRadius(3)
                        .animation(.easeInOut, value: quiz.progress)
                }
            }
            .frame(height: 6)
        }
        .padding()
        .background(Color.backgroundPrimary)
    }
}
