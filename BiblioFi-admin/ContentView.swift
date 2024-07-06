import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                DashboardView()
            } else {
                LoginPage()
            }
        }
        .onAppear {
            checkSignInStatus()
        }
    }
    
    private func checkSignInStatus() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isUserSignedIn")
    }
}

#Preview {
    ContentView()
}
