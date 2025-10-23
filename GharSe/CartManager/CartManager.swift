//
//  CartManager.swift
//  GharSe
//
//  Created by Saurabh Dutta on 17/10/25.
//

import Foundation

// Cart Manager
class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    
    // Add product
    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }
    
    // Remove product
    func removeFromCart(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    // Total price
    var totalPrice: Double {
        items.reduce(0) { total, item in
            let price = Double(item.product.price.replacingOccurrences(of: "$", with: "")) ?? 0
            return total + price * Double(item.quantity)
        }
    }
}

// Mock data - Not to be used for app. Just for previews
extension CartManager {
    static var preview: CartManager {
        let manager = CartManager()
        manager.items = [
            CartItem(product:
                        Product(name: "Apple", price: "$20.0", imageName: "", category: "Fruits"),
                     quantity: 2),
            CartItem(product:
                        Product(name: "Mango", price: "$40.0", imageName: "", category: "Fruits"),
                     quantity: 3)
        ]
        return manager
    }
}
