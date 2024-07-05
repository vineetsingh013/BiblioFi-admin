import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: String
    let admin = try? AuthenticationManager.shared.getAuthenticatedAdmin()

    var body: some View {
        VStack {
            VStack {
                Image("Screenshot_2024-07-03_at_8.55.37_PM-removebg-preview")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .padding(.top, 40)
                Text("Admin")
                    .font(.title)
                    .fontWeight(.bold)
                Text(admin!.email!)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding()

            VStack(alignment: .leading, spacing: 20) {
                Button(action: {
                    selectedTab = "Dashboard"
                }) {
                    HStack {
                        Image(systemName: "rectangle.grid.2x2")
                        Text("Dashboard")
                            .font(.title2)
                    }
                    .padding()
                    .background(selectedTab == "Dashboard" ? Color(.systemGray5) : Color.clear)
                    .cornerRadius(10)
                }

                Button(action: {
                    selectedTab = "Librarian"
                }) {
                    HStack {
                        Image(systemName: "book")
                        Text("Librarian")
                            .font(.title2)
                    }
                    .padding()
                    .background(selectedTab == "Librarian" ? Color(.systemGray5) : Color.clear)
                    .cornerRadius(10)
                }
            }
            .padding()

            Spacer()

            Button(action: {
                // Logout action
            }) {
                Text("Logout")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            .padding(.bottom, 30)
        }
        .frame(width: 250)
        .background(Color(.systemPink).opacity(0.2))
        .ignoresSafeArea()
    }
}

#Preview {
    SidebarView(selectedTab: .constant("Librarian"))
}
