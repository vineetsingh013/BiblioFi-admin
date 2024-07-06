

import Foundation
import SwiftUI

struct DashboardView: View {
    @State private var selectedTab: String = "Librarian"

    var body: some View {
        HStack {
            SidebarView(selectedTab: $selectedTab)
            if selectedTab == "Librarian" {
                LibrarianCreationView()
            } else {
                Text("Dashboard Content")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGray6))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DashboardView()
}
