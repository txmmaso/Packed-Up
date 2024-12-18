import SwiftUI

struct SuitcaseCardView: View {
    let suitcase: Suitcase

    var body: some View {
        ZStack {
            // Gradient background
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [suitcase.color.opacity(0.8), suitcase.color]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 3)
            
            HStack {
                // Destination Text
                VStack(alignment: .leading, spacing: 8) {
                    Text("Trip to \(suitcase.destination)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Suitcase Image
                Image(suitcase.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            .padding()
        }
        .frame(height: 100)
    }
}

// MARK: - Preview
struct SuitcaseCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuitcaseCardView(suitcase: Suitcase(
            destination: "Paris",
            color: .blue,
            imageName: "BlueSuitcase"
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
