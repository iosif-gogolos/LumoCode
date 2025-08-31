//
//  CategorySelectionView.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

struct CategorySelectionView: View {
    @Binding var userName: String
    @Binding var selectedCategory: QuizCategory?
    @Binding var showQuiz: Bool
    
    var body: some View {
        ZStack {
            ForEach(0..<50, id: \.self) { i in
                Image("Star")
                    .resizable()
                    .frame(width: CGFloat.random(in: 3...10), height: CGFloat.random(in: 3...10))
                    .opacity(Double.random(in: 0.05...0.15))
                    .offset(
                        x: CGFloat.random(in: -200...200),
                        y: CGFloat.random(in: -400...400)
                    )
            }
            
            // Planet Lumo
            Image("LumosPlanetWithHouse")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .opacity(0.3)
                .offset(x: 100, y: 200)
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(String(format: NSLocalizedString("hello_user", comment: ""), userName))
                            .font(.title2)
                            .bold()
                        Text(LocalizedStringKey("choose_category"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image("LumoExplains")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                .padding(.horizontal)
                
                // Categories Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(quizCategories) { category in
                        NavigationLink(
                            destination: QuizView(
                                quiz: QuizState(questions: category.questions),
                                categoryTitle: category.title,
                                userName: $userName,
                                selectedCategory: $selectedCategory,
                                showQuiz: $showQuiz
                            )
                        ) {
                            CategoryCard(category: category)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
