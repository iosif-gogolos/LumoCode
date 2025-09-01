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
    
    // MARK: - Swift Grundlagen (10 Fragen)
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
            ),
            Question(
                textKey: "q_string_interpolation",
                answers: ["\"Hello \\(name)\"", "\"Hello \" + name", "\"Hello {name}\""],
                correctAnswer: 0,
                explanationKey: "e_string_interpolation"
            ),
            Question(
                textKey: "q_optional_syntax",
                answers: ["String!", "String?", "String*"],
                correctAnswer: 1,
                explanationKey: "e_optional_syntax"
            ),
            Question(
                textKey: "q_nil_check",
                answers: ["if name == null", "if name == nil", "if name == undefined"],
                correctAnswer: 1,
                explanationKey: "e_nil_check"
            ),
            Question(
                textKey: "q_force_unwrap",
                answers: ["name*", "name!", "name?"],
                correctAnswer: 1,
                explanationKey: "e_force_unwrap"
            ),
            Question(
                textKey: "q_type_inference",
                answers: ["Swift kann Typen automatisch erkennen", "Alle Typen müssen explizit angegeben werden", "Nur Zahlen werden automatisch erkannt"],
                correctAnswer: 0,
                explanationKey: "e_type_inference"
            ),
            Question(
                textKey: "q_array_declaration",
                answers: ["var numbers = [Int]()", "var numbers = Array<Int>", "Beide sind korrekt"],
                correctAnswer: 2,
                explanationKey: "e_array_declaration"
            ),
            Question(
                textKey: "q_dictionary_syntax",
                answers: ["[String: Int]", "[String -> Int]", "[String, Int]"],
                correctAnswer: 0,
                explanationKey: "e_dictionary_syntax"
            )
        ]
    ),
    
    // MARK: - Funktionen (7 Fragen)
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
            ),
            Question(
                textKey: "q_function_parameters",
                answers: ["func greet(name: String)", "func greet(String name)", "func greet(name String)"],
                correctAnswer: 0,
                explanationKey: "e_function_parameters"
            ),
            Question(
                textKey: "q_function_return_type",
                answers: ["func calculate() -> Int", "func calculate(): Int", "func calculate() returns Int"],
                correctAnswer: 0,
                explanationKey: "e_function_return_type"
            ),
            Question(
                textKey: "q_external_parameter",
                answers: ["func greet(to name: String)", "func greet(name to: String)", "func greet(to: name String)"],
                correctAnswer: 0,
                explanationKey: "e_external_parameter"
            ),
            Question(
                textKey: "q_default_parameter",
                answers: ["func greet(name: String = \"World\")", "func greet(name: String default \"World\")", "func greet(name: String := \"World\")"],
                correctAnswer: 0,
                explanationKey: "e_default_parameter"
            ),
            Question(
                textKey: "q_variadic_parameter",
                answers: ["func sum(_ numbers: Int...)", "func sum(_ numbers: [Int])", "func sum(_ numbers: Int*)"],
                correctAnswer: 0,
                explanationKey: "e_variadic_parameter"
            ),
            Question(
                textKey: "q_inout_parameter",
                answers: ["func swap(_ a: inout Int, _ b: inout Int)", "func swap(_ a: ref Int, _ b: ref Int)", "func swap(_ a: var Int, _ b: var Int)"],
                correctAnswer: 0,
                explanationKey: "e_inout_parameter"
            ),
        ]
    ),
    
    // MARK: - Schleifen & Kontrollfluss (7 Fragen)
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
            ),
            Question(
                textKey: "q_range_operator",
                answers: ["1...5", "1..5", "1-5"],
                correctAnswer: 0,
                explanationKey: "e_range_operator"
            ),
            Question(
                textKey: "q_half_open_range",
                answers: ["1..<5", "1..5", "1<5"],
                correctAnswer: 0,
                explanationKey: "e_half_open_range"
            ),
            Question(
                textKey: "q_break_statement",
                answers: ["Beendet die aktuelle Schleife", "Überspringt eine Iteration", "Startet die Schleife neu"],
                correctAnswer: 0,
                explanationKey: "e_break_statement"
            ),
            Question(
                textKey: "q_continue_statement",
                answers: ["Beendet die Schleife", "Überspringt zur nächsten Iteration", "Pausiert die Schleife"],
                correctAnswer: 1,
                explanationKey: "e_continue_statement"
            ),
            Question(
                textKey: "q_labeled_statement",
                answers: ["outerLoop: for i in 1...5", "label outerLoop: for i in 1...5", "@outerLoop for i in 1...5"],
                correctAnswer: 0,
                explanationKey: "e_labeled_statement"
            )
        ]
    ),
    
    // MARK: - Objektorientierung (7 Fragen)
    QuizCategory(
        titleKey: "oop_basics",
        icon: "class",
        color: "purple",
        questions: [
            Question(
                textKey: "q_class_definition",
                answers: ["class MyClass {}", "Class MyClass {}", "class MyClass() {}"],
                correctAnswer: 0,
                explanationKey: "e_class_definition"
            ),
            Question(
                textKey: "q_inheritance_syntax",
                answers: ["class Child: Parent", "class Child extends Parent", "class Child inherits Parent"],
                correctAnswer: 0,
                explanationKey: "e_inheritance_syntax"
            ),
            Question(
                textKey: "q_override_keyword",
                answers: ["override func method()", "overwrite func method()", "redefine func method()"],
                correctAnswer: 0,
                explanationKey: "e_override_keyword"
            ),
            Question(
                textKey: "q_initializer_syntax",
                answers: ["init(name: String)", "constructor(name: String)", "new(name: String)"],
                correctAnswer: 0,
                explanationKey: "e_initializer_syntax"
            ),
            Question(
                textKey: "q_designated_initializer",
                answers: ["Der Haupt-Initializer einer Klasse", "Ein optionaler Initializer", "Ein privater Initializer"],
                correctAnswer: 0,
                explanationKey: "e_designated_initializer"
            ),
            Question(
                textKey: "q_convenience_initializer",
                answers: ["convenience init()", "optional init()", "secondary init()"],
                correctAnswer: 0,
                explanationKey: "e_convenience_initializer"
            ),
            Question(
                textKey: "q_deinitializer",
                answers: ["deinit {}", "destroy {}", "finalize {}"],
                correctAnswer: 0,
                explanationKey: "e_deinitializer"
            )
        ]
    ),
    
    // MARK: - Fehlerbehandlung (7 Fragen)
    QuizCategory(
        titleKey: "error_handling",
        icon: "exclamationmark",
        color: "red",
        questions: [
            Question(
                textKey: "q_error_protocol",
                answers: ["Error", "Exception", "Throwable"],
                correctAnswer: 0,
                explanationKey: "e_error_protocol"
            ),
            Question(
                textKey: "q_throwing_function",
                answers: ["func canThrow() throws", "func canThrow() throw", "func canThrow() throwing"],
                correctAnswer: 0,
                explanationKey: "e_throwing_function"
            ),
            Question(
                textKey: "q_try_keyword",
                answers: ["try someFunction()", "attempt someFunction()", "call someFunction()"],
                correctAnswer: 0,
                explanationKey: "e_try_keyword"
            ),
            Question(
                textKey: "q_do_catch_syntax",
                answers: ["do { try code } catch { handle }", "try { code } catch { handle }", "attempt { code } catch { handle }"],
                correctAnswer: 0,
                explanationKey: "e_do_catch_syntax"
            ),
            Question(
                textKey: "q_try_optional",
                answers: ["try?", "try!", "try*"],
                correctAnswer: 0,
                explanationKey: "e_try_optional"
            ),
            Question(
                textKey: "q_try_force",
                answers: ["try!", "try?", "try*"],
                correctAnswer: 0,
                explanationKey: "e_try_force"
            ),
            Question(
                textKey: "q_defer_statement",
                answers: ["defer { cleanup() }", "finally { cleanup() }", "ensure { cleanup() }"],
                correctAnswer: 0,
                explanationKey: "e_defer_statement"
            )
        ]
    ),
    
    // MARK: - SwiftUI Grundlagen (7 Fragen)
    QuizCategory(
        titleKey: "swiftui_basics",
        icon: "app",
        color: "cyan",
        questions: [
            Question(
                textKey: "q_view_protocol",
                answers: ["View", "UIView", "Component"],
                correctAnswer: 0,
                explanationKey: "e_view_protocol"
            ),
            Question(
                textKey: "q_body_property",
                answers: ["var body: some View", "var body: View", "var body: UIView"],
                correctAnswer: 0,
                explanationKey: "e_body_property"
            ),
            Question(
                textKey: "q_state_property",
                answers: ["@State", "@StateObject", "@Binding"],
                correctAnswer: 0,
                explanationKey: "e_state_property"
            ),
            Question(
                textKey: "q_binding_property",
                answers: ["@Binding", "@State", "@Published"],
                correctAnswer: 0,
                explanationKey: "e_binding_property"
            ),
            Question(
                textKey: "q_observableobject",
                answers: ["@StateObject", "@ObservedObject", "Beide sind korrekt"],
                correctAnswer: 2,
                explanationKey: "e_observableobject"
            ),
            Question(
                textKey: "q_vstack_hstack",
                answers: ["VStack für vertikal, HStack für horizontal", "VStack für horizontal, HStack für vertikal", "Beide sind gleich"],
                correctAnswer: 0,
                explanationKey: "e_vstack_hstack"
            ),
            Question(
                textKey: "q_navigationview",
                answers: ["NavigationView { content }", "NavigationStack { content }", "Beide sind möglich"],
                correctAnswer: 2,
                explanationKey: "e_navigationview"
            )
        ]
    )
]



