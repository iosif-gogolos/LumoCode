//
//  ContentView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct ContentView: View{
    @State private var userName: String = ""
    @State private var hasEnteredName: Bool = false
    @State private var selectedCategory: QuizCategory?
    @State private var showQuiz: Bool = false
    
    var body: some View {
        NavigationStack {
            if !hasEnteredName {
                WelcomeView(userName: $userName, hasEnteredName: $hasEnteredName)
            } else {
                CategorySelectionView(userName: $userName, selectedCategory: $selectedCategory, showQuiz: $showQuiz)
            }
        }
        .navigationDestination(isPresented: $showQuiz) {
            if let category = selectedCategory {
                QuizView(
                    quiz: QuizState(questions: category.questions),
                    categoryTitle: category.title,
                    userName: $userName,
                    selectedCategory: $selectedCategory,
                    showQuiz: $showQuiz
                )
            }
        }
    }
    
    
    struct WelcomeView: View {
        @Binding var userName: String
        @Binding var hasEnteredName: Bool
        @State private var lumoScale: CGFloat = 1.0
        @State private var showError: Bool = false
        
        @ObservedObject private var keyboard = KeyboardResponder() 

        
        var body: some View {
            ZStack {
                // Sterne-Hintergrund
                ForEach(0..<20, id: \.self) { i in
                    Image("Star")
                        .resizable()
                        .frame(width: CGFloat(Int.random(in: 8...20)), height: CGFloat(Int.random(in: 8...20)))
                        .opacity(Double.random(in: 0.05...0.2))
                        .position(
                            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                            y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                        )
                }
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Lumo im Raumschiff
                    Image("LumoInSpaceShip")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .scaleEffect(lumoScale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                lumoScale = 1.05
                            }
                        }
                    
                    Text(LocalizedStringKey("welcome_to"))
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text(LocalizedStringKey("app_name"))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                    Text(LocalizedStringKey("app_description"))
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 10) {
                        TextField("Dein Name", text: $userName)
                            .textFieldStyle(.roundedBorder)
                            .font(.headline)
                            .padding(.horizontal)
                            .submitLabel(.done) // zeigt auf iOS 15+ einen Done-Button in der Tastatur
                            .onSubmit {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        
                        if showError {
                            Text("Bitte gib deinen Namen ein!")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        Button(action: {
                            if userName.trimmingCharacters(in: .whitespaces).isEmpty {
                                showError = true
                            } else {
                                showError = false
                                withAnimation(.bouncy) {
                                    hasEnteredName = true
                                }
                            }
                        }) {
                            Text("Los geht's")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, keyboard.currentHeight)
                .animation(.easeOut(duration: 0.3), value: keyboard.currentHeight)
            }
            .ignoresSafeArea()
        }
    }
    
}





