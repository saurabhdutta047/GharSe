//
//  ProductDetailsView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    @State private var showToast = false
    
    var totalCartItems: Int {
        cartManager.items.reduce(0) { $0 + $1.quantity }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .foregroundColor(.primary)
            
            Text(product.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(product.price)
                .font(.title2)
                .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                Button(action: { decrementQuantity() }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                
                Text("\(currentQuantity())")
                    .font(.title2)
                    .frame(width: 40)
                
                Button(action: { incrementQuantity() }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            
            Button(action: {
                addToCart()
                showToastMessage()
            }) {
                Text("Add to Cart")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(product.name)
        .toolbar {
            // Cart button in toolbar
            NavigationLink(destination: CartView().environmentObject(cartManager)) {
                ZStack {
                    Image(systemName: "cart.fill")
                        .font(.title2)
                    
                    if totalCartItems > 0 {
                        Text("\(totalCartItems)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 12, y: -10)
                    }
                }
                .frame(width: 44, height: 44)
            }
        }
        .overlay(
            VStack {
                if showToast {
                    Text("Added to Cart!")
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .animation(.easeInOut, value: showToast),
            alignment: .top
        )
    }
    
    // MARK: - Cart Logic
    private func currentQuantity() -> Int {
        cartManager.items.first(where: { $0.product.id == product.id })?.quantity ?? 1
    }
    
    private func incrementQuantity() {
        if let index = cartManager.items.firstIndex(where: { $0.product.id == product.id }) {
            cartManager.items[index].quantity += 1
        } else {
            cartManager.addToCart(product: product)
        }
    }
    
    private func decrementQuantity() {
        if let index = cartManager.items.firstIndex(where: { $0.product.id == product.id }) {
            let newQuantity = max(cartManager.items[index].quantity - 1, 1)
            cartManager.items[index].quantity = newQuantity
        }
    }
    
    private func addToCart() {
        if let _ = cartManager.items.firstIndex(where: { $0.product.id == product.id }) {
            // Already in cart
        } else {
            cartManager.addToCart(product: product)
        }
    }
    
    private func showToastMessage() {
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    var product = Product(name: "Apple", price: "$1.5", imageName: "applelogo", category: "Fruits")
    ProductDetailsView(product: product)
        .environmentObject(CartManager.preview)
}
