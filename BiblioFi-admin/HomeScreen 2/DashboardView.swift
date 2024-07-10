

import Foundation
import SwiftUI


struct DashboardView: View {
    @State private var selectedTab: String = "Dashboard"
    let libraryStats: LibraryStats

    var body: some View {
        HStack {
            SidebarView(selectedTab: $selectedTab)
                .frame(minWidth: 250)
            if selectedTab == "Librarian" {
                LibrarianCreationView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGray6))
            } else {
                LibraryStatsView(libraryStats: libraryStats)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGray6))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DashboardView(libraryStats: sampleLibraryStats)
}
