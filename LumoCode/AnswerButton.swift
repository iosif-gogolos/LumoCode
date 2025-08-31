//
//  AnswerButton.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI


struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if isCorrect { return .correctAnswer }
        if isWrong { return .wrongAnswer }
        if isSelected { return .selectedAnswer.opacity(0.3) }
        return .backgroundCard
    }
    
    var borderColor: Color {
        if isCorrect { return .correctAnswer }
        if isWrong { return .wrongAnswer }
        if isSelected { return .selectedAnswer }
        return .backgroundCard
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
            .shadow(color: borderColor.opacity(0.1), radius: 3, x: 0, y: 2)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .animation(.easeInOut(duration: 0.2), value: backgroundColor)
    }
}
                    

