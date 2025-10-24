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

    // MARK: - Public API

    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }

    func decrement(product: Product) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        items[index].quantity -= 1
        if items[index].quantity <= 0 {
            items.remove(at: index)
        }
    }

    func removeFromCart(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func quantity(for product: Product) -> Int {
        items.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
// Mock data - Not to be used for app. Just for previews
extension CartManager {
    static var preview: CartManager {
        let manager = CartManager()
        manager.items = [
            CartItem(product:
                        Product(name: "Apple", price: 20.0, imageName: "", category: "Fruits"),
                     quantity: 2),
            CartItem(product:
                        Product(name: "Mango", price: 40.0, imageName: "", category: "Fruits"),
                     quantity: 3)
        ]
        return manager
    }
}
