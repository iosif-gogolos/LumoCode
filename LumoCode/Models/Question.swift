//
//  Question.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//
import SwiftUI
import Foundation


import Foundation

struct Question {
    let textKey: String // Statt text: String
    let answers: [String]
    let correctAnswer: Int
    let explanationKey: String // Statt explanation: String
    
    // Computed Properties für lokalisierte Texte
    var text: String {
        NSLocalizedString(textKey, comment: "Question text")
    }
    
    var explanation: String {
        NSLocalizedString(explanationKey, comment: "Question explanation")
    }
}

struct QuizCategory: Identifiable {
    let id = UUID()
    let titleKey: String // Statt title: String
    let icon: String
    let color: String
    let questions: [Question]
    
    var questionCount: Int {
        questions.count
    }
    
    // Computed Property für lokalisierten Titel
    var title: String {
        NSLocalizedString(titleKey, comment: "Category title")
    }
}

class QuizState: ObservableObject {
    @Published var questions: [Question]
    @Published var currentIndex: Int = 0
    @Published var score: Int = 0
    @Published var streak: Int = 0
    @Published var bestStreak: Int = 0
    @Published var answeredQuestions: Int = 0
    @Published var correctAnswers: Int = 0
    
    var currentQuestion: Question {
        guard currentIndex < questions.count else {
            return Question(textKey: "", answers: [], correctAnswer: 0, explanationKey: "")
        }
        return questions[currentIndex]
    }
    
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentIndex) / Double(questions.count)
    }
    
    var accuracy: Double {
        guard answeredQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(answeredQuestions) * 100
    }
    
    var totalPoints: Int {
        correctAnswers * 10 // 10 Punkte pro richtige Antwort
    }
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func checkAnswer(_ index: Int) -> Bool {
        let isCorrect = index == currentQuestion.correctAnswer
        answeredQuestions += 1
        
        if isCorrect {
            score += 1
            correctAnswers += 1
            streak += 1
            if streak > bestStreak {
                bestStreak = streak
            }
        } else {
            streak = 0
        }
        return isCorrect
    }
    
    func nextQuestion() -> Bool {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        currentIndex = 0
        score = 0
        streak = 0
        answeredQuestions = 0
        correctAnswers = 0
    }
}

// Lokalisierte Quiz-Kategorien
let quizCategories: [QuizCategory] = [
    QuizCategory(
        titleKey: "swift_basics",
        icon: "swift",
        color: "orange",
        questions: [
            Question(
                textKey: "q_variable_declaration",
                answers: ["var", "let", "const"],
                correctAnswer: 0,
                explanationKey: "e_variable_declaration"
            ),
            Question(
                textKey: "q_constant_creation",
                answers: ["const name = \"Lumo\"", "let name = \"Lumo\"", "var name = \"Lumo\""],
                correctAnswer: 1,
                explanationKey: "e_constant_creation"
            ),
            Question(
                textKey: "q_integer_type",
                answers: ["String", "Double", "Int"],
                correctAnswer: 2,
                explanationKey: "e_integer_type"
            )
        ]
    ),
    QuizCategory(
        titleKey: "functions",
        icon: "function",
        color: "blue",
        questions: [
            Question(
                textKey: "q_function_definition",
                answers: ["func myFunction() {}", "function myFunction() {}", "def myFunction():"],
                correctAnswer: 0,
                explanationKey: "e_function_definition"
            ),
            Question(
                textKey: "q_function_return",
                answers: ["return value", "give value", "send value"],
                correctAnswer: 0,
                explanationKey: "e_function_return"
            )
        ]
    ),
    QuizCategory(
        titleKey: "loops",
        icon: "repeat",
        color: "green",
        questions: [
            Question(
                textKey: "q_for_in_loop",
                answers: ["while", "for-in", "repeat"],
                correctAnswer: 1,
                explanationKey: "e_for_in_loop"
            ),
            Question(
                textKey: "q_repeat_while",
                answers: ["for-in", "while", "repeat-while"],
                correctAnswer: 2,
                explanationKey: "e_repeat_while"
            )
        ]
    )
]



