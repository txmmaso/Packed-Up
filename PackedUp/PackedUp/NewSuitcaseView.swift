import SwiftUI

// MARK: - NewSuitcaseView
struct NewSuitcaseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var destination = ""
    @State private var selectedColor: Color = .clear
    @State private var selectedImageName: String = ""
    
    // Suitcase options: colors and images
    let suitcaseOptions: [(color: Color, imageName: String)] = [
        (.red, "RedSuitcase"),
        (.orange, "OrangeSuitcase"),
        (.black, "BlackSuitcase"),
        (.blue, "BlueSuitcase"),
        (.pink, "PinkSuitcase"),
        (.green, "GreenSuitcase")
    ]
    
    var onSave: (Suitcase) -> Void // Closure to return the suitcase to the parent view
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header Text
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your New Suitcase")
                        .padding(.top, 20)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                    Text("Give your suitcase a destination.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Destination TextField
                TextField("Destination...", text: $destination)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Suitcase Selection Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                    ForEach(suitcaseOptions, id: \.imageName) { option in
                        Button(action: {
                            selectedColor = option.color
                            selectedImageName = option.imageName
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(option.color.opacity(0.2))
                                    .aspectRatio(1, contentMode: .fit) // Makes squares
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedColor == option.color ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                
                                Image(option.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Create Suitcase Button
                Button(action: {
                    if !destination.isEmpty && selectedColor != .clear {
                        let newSuitcase = Suitcase(
                            destination: destination,
                            color: selectedColor,
                            imageName: selectedImageName
                           
                        )
                        onSave(newSuitcase)
                        dismiss()
                    }
                }) {
                    Text("Create Suitcase")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
    }
}

// MARK: - Preview
struct NewSuitcaseView_Previews: PreviewProvider {
    static var previews: some View {
        NewSuitcaseView { _ in }
    }
}
