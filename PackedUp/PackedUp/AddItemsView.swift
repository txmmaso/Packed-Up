import SwiftUI

struct AddItemsView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Categories and Items
    let categories: [String: (symbol: String, items: [String])] = [
        "Essentials": ("briefcase", ["Passport", "ID", "Travel itinerary", "Visa", "Cash", "Credit Card", "Travel Insurance", "Power Adaptor", "Boarding Pass", "Health Insurance"]),
        "Clothes": ("tshirt", ["Shirts", "Pants", "Jackets", "Socks", "Shoes", "Belt", "Hat", "Scarf", "Gloves"]),
        "Toiletries": ("toothbrush", ["Toothbrush", "Toothpaste", "Shampoo", "Conditioner", "Soap", "Razor", "Deodorant", "Towel", "Nail Clippers"]),
        "Makeup": ("eyedropper", ["Foundation", "Mascara", "Lipstick", "Blush", "Makeup Remover", "Brush Set", "Mirror"]),
        "Carry-on": ("bag", ["Laptop", "Headphones", "Book", "Snacks", "Water Bottle", "Notebook", "Pen", "Charger"]),
        "Hot Weather": ("sun.max", ["Sunglasses", "Shorts", "Swimsuit", "Flip-Flops", "Sunscreen", "Hat"]),
        "Cold Weather": ("snowflake", ["Coat", "Sweater", "Thermals", "Beanie", "Gloves", "Boots", "Scarf"]),
        "Work": ("briefcase.fill", ["Laptop", "Documents", "Pen", "Notebook", "Business Cards", "Planner"])
    ]
    
    // Selected items to pass back
    @State private var selectedItems: Set<String> = []
    var onItemsSelected: ([String]) -> Void // Callback to send selected items back
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories.keys.sorted(), id: \.self) { category in
                    Section(header: Label(category, systemImage: categories[category]?.symbol ?? "list.bullet")) {
                        if let items = categories[category]?.items {
                            ForEach(items, id: \.self) { item in
                                MultipleSelectionRow(item: item, isSelected: selectedItems.contains(item)) {
                                    if selectedItems.contains(item) {
                                        selectedItems.remove(item)
                                    } else {
                                        selectedItems.insert(item)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        onItemsSelected(Array(selectedItems))
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - MultipleSelectionRow View
struct MultipleSelectionRow: View {
    let item: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(item)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

// MARK: - Preview
struct AddItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemsView { _ in }
    }
}
