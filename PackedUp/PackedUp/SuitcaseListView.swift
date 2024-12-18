import SwiftUI

struct SuitcaseListView: View {
    var suitcases: [Suitcase]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                ForEach(suitcases) { suitcase in
                    SuitcaseCardView(suitcase: suitcase)
                }
            }
            .padding(.top, 50)
        }
    }
}
