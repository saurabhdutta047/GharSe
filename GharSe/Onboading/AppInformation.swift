//
//  AppInformation.swift
//  GharSe
//
//  Created by Saurabh Dutta on 23/10/25.
//

import SwiftUI

struct AppInformation: View {
    var logo: String
    var title: String
    var description: String
    var body: some View {
        VStack(spacing: 10){
            // App logo
            Image(systemName: logo)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)
            
            // Welcome text
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    let logo = "star.fill"
    let title = "Ghar se"
    let description = "Experience the best features and stay connected."
    AppInformation(logo: logo, title: title, description: description)
}
