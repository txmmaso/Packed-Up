import SwiftUI

struct HomeView: View {
    @State private var isPresentingNewSuitcase = false
    @State private var suitcases: [Suitcase] = [] // Stores created suitcases
    
    var body: some View {
        NavigationView {
            VStack {
                if suitcases.isEmpty {
                    // Placeholder View
                    Spacer()
                    
                    Image("EmptySuitcase") // Custom placeholder suitcase image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150)
                        .foregroundColor(.orange)
                    
                    Text("Let’s pack it up!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Get started with your first suitcase.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.bottom, 6)
                    
                    Button(action: {
                        isPresentingNewSuitcase = true
                    }) {
                        Text("Get Started")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                            .padding(.horizontal, 130)
                            .padding(.top, 18)
                    }
                    
                    Spacer()
                } else {
                    // Suitcase List View
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(suitcases) { suitcase in
                                NavigationLink(destination: SuitcaseDetailView(suitcase: suitcase)) {
                                    SuitcaseCardView(suitcase: suitcase)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Suitcases")
            .navigationBarBackButtonHidden(true) // Hide the back button in HomeView
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingNewSuitcase = true
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewSuitcase) {
                NewSuitcaseView { newSuitcase in
                    suitcases.append(newSuitcase) // Save the new suitcase
                }
            }
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
