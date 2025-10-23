import SwiftUI

struct OnboardingContentView: View {
    var logo: String
    var title: String
    var description: String
    var logoColor: Color = .blue
    var spacing: CGFloat = 20
    
    var body: some View {
        VStack(spacing: spacing) {
            // App logo
            Image(systemName: logo)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(logoColor)
            
            // Title text
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8) // ensures title scales on smaller devices
            
            // Description text
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30) // consistent horizontal padding
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // ensures proper background in light/dark mode
    }
}

#Preview {
    OnboardingContentView(
        logo: "star.fill",
        title: "GharSe",
        description: "Experience the best features and stay connected."
    )
}
