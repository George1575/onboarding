//
//  OnBoardingViewApp.swift
//  OnBoardingView
//
//  Created by George Hargreaves on 24/09/2023.
//

import SwiftUI

@main
struct OnBoardingViewApp: App {
    
    let model = JSONdecoder()
    
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(model)
        }
    }
}
