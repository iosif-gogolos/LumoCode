//
//  LumoCodeColors.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//
//
//  Color Assets Manager für LumoCode
//  Definiert alle Farben als Assets mit Dark Mode Support
//

import SwiftUI


// Iosif Gogolos-Productions SplashScreen
struct IGProductionsSplashScreen: View {
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var backgroundOpacity: Double = 1.0
    @State private var showMainApp: Bool = false
    
    var body: some View {
        if showMainApp {
            ContentView()
                .transition(.opacity)
        } else {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.backgroundPrimary,
                        Color.backgroundSecondary
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(backgroundOpacity)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // IG Productions Logo
                    VStack(spacing: 20) {
                        Image("IGProductions")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .scaleEffect(logoScale)
                            .opacity(logoOpacity)
                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    // Loading Indicator
                    VStack(spacing: 15) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .lumoPrimary))
                            .scaleEffect(1.2)
                            .opacity(logoOpacity)
                        
                        Text("Lädt...")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                            .opacity(logoOpacity)
                    }
                    
                    Spacer().frame(height: 100)
                }
            }
            .onAppear {
                startSplashAnimation()
            }
        }
    }
    
    private func startSplashAnimation() {
        // Logo Fade In Animation
        withAnimation(.easeOut(duration: 1.0)) {
            logoOpacity = 1.0
        }
        
        // Logo Scale Animation
        withAnimation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0.5).delay(0.3)) {
            logoScale = 1.0
        }
        
        // Transition to Main App
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 0.8)) {
                backgroundOpacity = 0.0
                showMainApp = true
            }
        }
    }
}








// MARK: - Updated Progress Bar mit Color Assets


// MARK: - Updated Feedback Section mit Color Assets
struct FeedbackSection: View {
    let isCorrect: Bool
    let explanation: String
    let onContinue: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Feedback Message
            HStack {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(isCorrect ? .correctAnswer : .wrongAnswer)
                
                Text(LocalizedStringKey(isCorrect ? "correct" : "wrong"))
                    .font(.headline)
                    .foregroundColor(isCorrect ? .correctAnswer : .wrongAnswer)
            }
            
            // Explanation Card
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    ResponsiveLumoImage(.explains, size: .small)
                        .frame(width: 30, height: 30)
                    
                    Text(LocalizedStringKey("explanation"))
                        .font(.headline)
                        .foregroundColor(.textPrimary)
                }
                
                Text(explanation)
                    .font(.body)
                    .foregroundColor(.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color.backgroundCard)
            .cornerRadius(16)
            .shadow(color: .textSecondary.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Continue Button
            Button(action: onContinue) {
                HStack {
                    Text(LocalizedStringKey("continue"))
                    Image(systemName: "arrow.right")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.lumoPrimary, .lumoSecondary],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: .lumoPrimary.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
    }
}

