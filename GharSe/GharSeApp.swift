//
//  GharSeApp.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

@main
struct GharSeApp: App {
    @StateObject var cartManager = CartManager() // single global instance
    var body: some Scene {
        WindowGroup {
            let viewModel = OnboardingViewModel(dto: OnboardingDTO())
            OnboardingView(viewModel: viewModel)
                .environmentObject(cartManager) // pass it to onboarding
        }
    }
}
