//
//  Question.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: Int
}

struct QuizState {
    var questions: [Question]
    private(set) var currentIndex: Int = 0
    private(set) var score: Int = 0
    private(set) var streak: Int = 0
    
    var currentQuestion: Question {
        questions[currentIndex]
    }
    
    mutating func checkAnswer(_ index: Int) -> Bool {
        let isCorrect = index == currentQuestion.correctAnswer
        if isCorrect {
            score += 1
            streak += 1
        } else {
            streak = 0
        }
        return isCorrect
    }
    
    
    mutating func nextQuestion() -> Bool {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }
}

// Beispiel-Fragen
let sampleQuestions: [Question] = [
    Question(
        text: "Wie erstellt man eine Variable in Swift?",
        answers: [
            "var name = \"Lumo\"",
            "variable name = \"Lumo\"",
            "let name := \"Lumo\""
        ],
        correctAnswer: 0
    ),
    Question(
        text: "Welche Schleife wiederholt Code, solange eine Bedingung erfüllt ist?",
        answers: ["for-in", "while", "repeat-until"],
        correctAnswer: 1
    ),
    Question(
        text: "Welches Keyword deklariert eine Konstante?",
        answers: ["const", "protocol", "let"],
        correctAnswer: 2
    )
]
