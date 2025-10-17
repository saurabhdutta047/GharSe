//
//  CartView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack {
            if cartManager.items.isEmpty {
                Text("Your cart is empty")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            Text(item.product.name)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            // Quantity controls
                            HStack(spacing: 10) {
                                Button(action: {
                                    if item.quantity > 1 {
                                        updateQuantity(for: item, change: -1)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                }
                                
                                Text("\(item.quantity)")
                                    .frame(width: 25)
                                
                                Button(action: {
                                    updateQuantity(for: item, change: 1)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                }
                            }
                            
                            Text(item.product.price)
                                .padding(.leading, 10)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            cartManager.removeFromCart(item: cartManager.items[index])
                        }
                    }
                }
                
                HStack {
                    Text("Total:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
        .navigationTitle("Cart")
    }
    
    // Update item quantity
    private func updateQuantity(for item: CartItem, change: Int) {
        if let index = cartManager.items.firstIndex(where: { $0.id == item.id }) {
            let newQuantity = cartManager.items[index].quantity + change
            cartManager.items[index].quantity = max(newQuantity, 1)
        }
    }
}
