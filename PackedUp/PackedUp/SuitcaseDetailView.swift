import SwiftUI

struct SuitcaseDetailView: View {
    let suitcase: Suitcase
    @State private var isAddingItems = false
    @State private var items: [SuitcaseItem] = []
    
    var body: some View {
        VStack {
            // Suitcase Card
            SuitcaseCardView(suitcase: suitcase)
                .padding(.top)
                .padding(.trailing,10)
                .padding(.leading,10)
                .padding(.bottom, 15)

            
            // Items List
            if items.isEmpty {
                Spacer()
                Image("EmptySuitcase")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                Text("Nothing To Pack Yet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                Text("Let’s get started by adding a few items.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach($items) { $item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isPacked ? .green : .gray)
                                .onTapGesture {
                                    item.isPacked.toggle()
                                }
                        }
                    }
                }
            }
            
            Spacer()
            
            // Add Items Button
            Button(action: {
                isAddingItems = true
            }) {
                Text("Add Items")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.blue)
                    .cornerRadius(100)
            }
            .padding()
        }
        .sheet(isPresented: $isAddingItems) {
            AddItemsView { selectedItems in
                let newItems = selectedItems.map { SuitcaseItem(name: $0, isPacked: false) }
                items.append(contentsOf: newItems)
            }
        }
    }
}

// MARK: - SuitcaseItem Model
struct SuitcaseItem: Identifiable {
    let id = UUID()
    let name: String
    var isPacked: Bool
}

// MARK: - Preview
struct SuitcaseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSuitcase = Suitcase(destination: "Tokyo", color: .orange, imageName: "OrangeSuitcase")
        SuitcaseDetailView(suitcase: sampleSuitcase)
    }
}
