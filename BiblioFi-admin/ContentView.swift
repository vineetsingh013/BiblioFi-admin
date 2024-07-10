import SwiftUI

struct ContentView: View {
    var body: some View {
        DashboardView(libraryStats: sampleLibraryStats)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
    }
}

#Preview {
    ContentView()
}
