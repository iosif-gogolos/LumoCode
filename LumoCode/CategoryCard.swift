//
//  CategoryCard.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//
import SwiftUI

struct CategoryCard: View {
    let category: QuizCategory
    var cardColor: Color {
        switch category.color {
        case "orange": return .orange
        case "blue": return .blue
        case "green": return .green
        default: return .blue
        }
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(iconForCategory(category.icon))
                .font(.system(size: 40))
            
            Text(category.title)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(String(format: NSLocalizedString("questions_count", comment: ""), category.questions.count))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .foregroundColor(.white)
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .background(cardColor.gradient)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
    
    private func iconForCategory(_ icon: String) -> String {
        switch icon {
        case "swift": return "⚡"
        case "function": return "🔧"
        case "repeat": return "🔄"
        default: return "📚"
        }
    }
}
