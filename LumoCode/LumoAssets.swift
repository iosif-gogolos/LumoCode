//
//  LumoAsset.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI
import Foundation

struct LumoAssets{
    
    // empfohlene Größen
    enum ImageSize: String{
        case small = "100"
        case medium = "200"
        case large = "300"
        
        var suffix: String {
            return self.rawValue
        }
        
        var cgSize: CGSize {
            switch self {
            case .small: return CGSize(width: 100, height: 100)
            case .medium: return CGSize(width: 200, height: 200)
            case .large: return CGSize(width: 300, height: 300)
            }
        }
        
        // Statische Assets
        static let appIcon = "AppIcon"
        static let darkMode = "Darkmode"
        static let tinted = "Tinted"
    }
    
    // Lumo-Character States
    enum LumoState: String, CaseIterable{
        case normal = "Lumo"
        case explains = "LumoExplains"
        case motivator = "LumoMotivator"
        case speaks = "LumoSpeaks"
        case inSpace = "LumoInSpace"
        case inSpaceShip = "LumoInSpaceShip"
        
        func image(size: ImageSize = .medium) -> String {
            return "\(self.rawValue)\(size.suffix)"
        }
    }
    
    // Umgebungs-Assets
    enum Environment: String {
        case house = "LumosHouse"
        case spaceShip = "LumosSpaceShip"
        case planetWithHouse = "LumosPlanetWithHouse"
        
        func image(size: ImageSize = .medium) -> String {
            return "\(self.rawValue)\(size.suffix)"
        }
    }
    
    // Meilensteine
    enum Milestone: String{
        case active="MilestoneActive"
        case done="MilestoneDone"
        case inactive="MilestoneInctive"
        case trophyDone="MilestoneTrophyDone"
        case trophyInactive="MilestoneTrophyInactive"
        
        func image(size: ImageSize = .medium) -> String{
            return "\(self.rawValue)\(size.suffix)"
        }
    }
    
    // Logo
    enum Logo: String{
        case full = "Logo"
        case noText = "LogoNoText"
        case igProd = "IGProductions"
        
        func image(size: ImageSize = .medium) -> String{
            return "\(self.rawValue)\(size.suffix)"
        }
    }
}

// Responsive Image View

struct ResponsiveLumoImage: View{
    let state: LumoAssets.LumoState
    let size: LumoAssets.ImageSize
    let animation: Bool
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0.0
    
    init(_ state: LumoAssets.LumoState,
         size: LumoAssets.ImageSize = .medium,
         animation: Bool = false) {
        self.state = state
        self.size = size
        self.animation = animation
    }
    
    var body: some View {
        Image(state.image(size: size))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                if animation {
                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)){
                        scale = 1.1
                    }
                }
            }
        
    }
}

