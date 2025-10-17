//
//  OnboardingView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                // App logo or welcome image
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                
                // Welcome text
                Text("Ghar se")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Experience the best features and stay connected.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: HomeView().environmentObject(cartManager)) {
                        Text("Continue as a Buyer")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    
                    NavigationLink(destination: HomeView().environmentObject(cartManager)) {
                        Text("Continue as a Seller")
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
}


#Preview {
    OnboardingView()
}
