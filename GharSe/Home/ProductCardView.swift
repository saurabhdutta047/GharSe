//
//  ProductCartView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 24/10/25.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    let quantity: Int
    let onTap: () -> Void
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Product image (tappable)
            Button(action: onTap) {
                Image(systemName: product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .foregroundColor(.primary)
            }
            .buttonStyle(PlainButtonStyle())

            // Product info
            Text(product.name)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("$\(product.price, specifier: "%.2f")")
                .foregroundColor(.secondary)

            // Quantity controls
            HStack(spacing: 10) {
                Button(action: onDecrement) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(BorderlessButtonStyle())

                Text("\(quantity)")
                    .frame(width: 25)
                    .font(.body)
                    .multilineTextAlignment(.center)

                Button(action: onIncrement) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 22))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    ProductCardView(
        product: Product(name: "Apple", price: 20.0, imageName: "applelogo", category: "Fruits"),
        quantity: 2,
        onTap: {},
        onIncrement: {},
        onDecrement: {}
    )
    .previewLayout(.sizeThatFits)
    .padding()
}
