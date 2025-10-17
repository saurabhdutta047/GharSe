//
//  CartItem.swift
//  GharSe
//
//  Created by Saurabh Dutta on 17/10/25.
//

import Foundation

// Cart Item
struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
