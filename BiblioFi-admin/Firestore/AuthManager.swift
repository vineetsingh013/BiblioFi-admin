import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    
    private init() {}
    
    func createAdmin(email: String, password: String, phoneNumber: String, name: String) async throws -> Admin? {
        let authData = auth.currentUser
        guard let authDataResult = authData else { throw URLError(.badURL) }
        return Admin(id: authDataResult.uid, email: authDataResult.email, library: nil)
    }
    
    
    
}
