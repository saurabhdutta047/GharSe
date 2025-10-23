//
//  HomeView.swift
//  GharSe
//
//  Created by Saurabh Dutta on 02/10/25.
//

import SwiftUI

// Sample Models
struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let imageName: String
    let category: String
}

// Sample Data
let categories = [
    Category(name: "Fruits"),
    Category(name: "Vegetables"),
    Category(name: "Dairy"),
    Category(name: "Snacks"),
    Category(name: "Drinks")
]

let products = [
    Product(name: "Apple", price: "$1.5", imageName: "applelogo", category: "Fruits"),
    Product(name: "Orange", price: "$1.8", imageName: "sun.max.fill", category: "Fruits"),
    Product(name: "Milk", price: "$0.99", imageName: "drop.fill", category: "Dairy"),
    Product(name: "Bread", price: "$2.0", imageName: "bag.fill", category: "Dairy"),
    Product(name: "Chips", price: "$1.2", imageName: "leaf.fill", category: "Snacks")
]

// Home Page View
struct HomeView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var selectedCategory: String? = nil
    @State private var searchText = ""
    
    var filteredProducts: [Product] {
        products.filter { product in
            (selectedCategory == nil || product.category == selectedCategory) &&
            (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased()))
        }
    }
    
    // Total items in cart
    private var totalCartItems: Int {
        cartManager.items.reduce(0) { $0 + $1.quantity }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Search Bar
                    TextField("Search products...", text: $searchText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    // Categories
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            Button(action: { selectedCategory = nil }) {
                                Text("All")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(selectedCategory == nil ? Color.blue : Color.blue.opacity(0.2))
                                    .foregroundColor(selectedCategory == nil ? .white : .blue)
                                    .cornerRadius(20)
                            }
                            
                            ForEach(categories) { category in
                                Button(action: { selectedCategory = category.name }) {
                                    Text(category.name)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(selectedCategory == category.name ? Color.blue : Color.blue.opacity(0.2))
                                        .foregroundColor(selectedCategory == category.name ? .white : .blue)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Products Grid
                    Text("Products")
                        .font(.headline)
                        .padding([.horizontal, .top])
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredProducts) { product in
                            VStack(alignment: .leading, spacing: 10) {
                                NavigationLink(destination: ProductDetailsView(product: product).environmentObject(cartManager)) {
                                    Image(systemName: product.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 80)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .foregroundColor(.primary)
                                }
                                
                                Text(product.name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                
                                Text(product.price)
                                    .foregroundColor(.secondary)
                                
                                // Add to Cart Controls
                                HStack(spacing: 10) {
                                    Button(action: {
                                        decrementQuantity(product: product)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.blue)
                                            .font(.title3)
                                    }
                                    
                                    Text("\(currentQuantity(for: product))")
                                        .frame(width: 25)
                                    
                                    Button(action: {
                                        incrementQuantity(product: product)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.blue)
                                            .font(.title3)
                                    }
                                }
                                .padding(.top, 5)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Home")
            .toolbar {
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
                                .offset(x: 12, y: -10) // slightly adjusted offset
                        }
                    }
                    .frame(width: 44, height: 44) // ensures enough tappable area
                }
            }
        }
    }
    
    // MARK: - Quantity Helpers
    private func currentQuantity(for product: Product) -> Int {
        cartManager.items.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    private func incrementQuantity(product: Product) {
        if let index = cartManager.items.firstIndex(where: { $0.product.id == product.id }) {
            cartManager.items[index].quantity += 1
        } else {
            cartManager.addToCart(product: product)
        }
    }

    private func decrementQuantity(product: Product) {
        if let index = cartManager.items.firstIndex(where: { $0.product.id == product.id }) {
            let newQuantity = max(cartManager.items[index].quantity - 1, 0)
            if newQuantity == 0 {
                cartManager.removeFromCart(item: cartManager.items[index])
            } else {
                cartManager.items[index].quantity = newQuantity
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(CartManager.preview)
}
