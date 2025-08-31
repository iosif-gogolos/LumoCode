//
//  LumoCodeApp.swift
//  LumoCode
//
//  Created by Iosif Gogolos on 31.08.25.
//

import SwiftUI

@main

struct LumoCodeApp: App {
    var body: some Scene {
        WindowGroup {
            IGProductionsSplashScreen()
                .preferredColorScheme(nil) // Respektiert System-Einstellungen
        }
    }
}
