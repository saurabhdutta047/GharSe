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

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
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
    Product(name: "Apple", price: 130.0, imageName: "applelogo", category: "Fruits"),
    Product(name: "Orange", price: 80.0, imageName: "sun.max.fill", category: "Fruits"),
    Product(name: "Milk", price: 29.0, imageName: "drop.fill", category: "Dairy"),
    Product(name: "Bread", price: 45.0, imageName: "bag.fill", category: "Dairy"),
    Product(name: "Chips", price: 10.0, imageName: "leaf.fill", category: "Snacks")
]

// Home Page View
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var selectedProduct: Product? = nil
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil

    var filteredProducts: [Product] {
        products.filter { product in
            (selectedCategory == nil || product.category == selectedCategory) &&
            (searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased()))
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Search Bar
                    TextField("Search products...", text: $searchText)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)

                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            Button(action: { selectedCategory = nil }) {
                                Text("All")
                                    .categoryStyle(isSelected: selectedCategory == nil)
                            }

                            ForEach(categories) { category in
                                Button(action: { selectedCategory = category.name }) {
                                    Text(category.name)
                                        .categoryStyle(isSelected: selectedCategory == category.name)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Products Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredProducts) { product in
                            ProductCardView(
                                product: product,
                                quantity: cartManager.quantity(for: product),
                                onTap: { selectedProduct = product },
                                onIncrement: { cartManager.addToCart(product: product) },
                                onDecrement: { cartManager.decrement(product: product) }
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Home")
            .toolbar {
                NavigationLink(destination: CartView().environmentObject(cartManager)) {
                    CartBadgeView(totalItems: cartManager.items.reduce(0) { $0 + $1.quantity })
                }
            }
            .navigationDestination(item: $selectedProduct) { product in
                ProductDetailsView(product: product)
                    .environmentObject(cartManager)
            }
        }
    }
}

// Helpers

extension Text {
    func categoryStyle(isSelected: Bool) -> some View {
        self
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(isSelected ? Color.blue : Color.blue.opacity(0.2))
            .foregroundColor(isSelected ? .white : .blue)
            .cornerRadius(20)
    }
}

struct CartBadgeView: View {
    let totalItems: Int

    var body: some View {
        ZStack {
            Image(systemName: "cart.fill")
                .font(.title2)

            if totalItems > 0 {
                Text("\(totalItems)")
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

#Preview {
    HomeView()
        .environmentObject(CartManager.preview)
}
