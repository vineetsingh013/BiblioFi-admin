import Foundation
import SwiftUI

struct SidebarView: View {
    @Binding var selectedTab: String

    var body: some View {
        VStack {
            VStack {
                Image("owlLogo")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .padding(.top, 40)
                Text("Keshav Lohiya")
                    .font(.title)
                    .fontWeight(.bold)
                Text("hehe@gmail.com")
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
                    .background(selectedTab == "Dashboard" ? Color(hex: "FDF5E6") : Color.clear)
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
                    .background(selectedTab == "Librarian" ? Color(hex: "FDF5E6") : Color.clear)
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
        .background(Color(hex: "FDF5E6"))
        .ignoresSafeArea()
    }
}

#Preview {
    SidebarView(selectedTab: .constant("Librarian"))
}
