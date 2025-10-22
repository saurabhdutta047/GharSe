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
                        HStack(spacing: 12) {
                            // Product name
                            Text(item.product.name)
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            // Quantity controls
                            HStack(spacing: 12) {
                                Button {
                                    if item.quantity > 1 {
                                        updateQuantity(for: item, change: -1)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.blue)
                                        .frame(width: 36, height: 36)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // <— Important fix

                                Text("\(item.quantity)")
                                    .font(.body)
                                    .frame(width: 28)

                                Button {
                                    updateQuantity(for: item, change: 1)
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.blue)
                                        .frame(width: 36, height: 36)
                                }
                                .buttonStyle(BorderlessButtonStyle()) // <— Important fix
                            }

                            // Price
                            Text(item.product.price)
                                .font(.body)
                                .fontWeight(.medium)
                                .frame(width: 70, alignment: .trailing)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
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
