//
//  OnboardingView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var cartManager: CartManager
    let viewModel: OnboardingViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                AppInformation(logo: viewModel.dto.logo, title: viewModel.dto.title, description: viewModel.dto.description)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: HomeView().environmentObject(cartManager)) {
                        Text(viewModel.dto.primaryButtonTitle)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    
                    NavigationLink(destination: HomeView().environmentObject(cartManager)) {
                        Text(viewModel.dto.secondaryButtonTitle)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer()
            }
            .padding()
        }
    }
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(dto: OnboardingDTO()))
        .environmentObject(CartManager.preview)
}
