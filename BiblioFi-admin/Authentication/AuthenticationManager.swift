//
//  AuthenticationManager.swift
//  BiblioFi-admin
//
//  Created by Akshat Kamboj on 04/07/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResult {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    
    static let shared = AuthenticationManager()
    private init() { }
    
    
    func createLibrarian(email: String, password: String) async throws -> AuthDataResult{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    func loginUser(email: String, password: String) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    func getAuthenticatedAdmin() throws -> AuthDataResult {
        guard let user = Auth.auth().currentUser else { throw URLError(.badServerResponse)}
        return AuthDataResult(user: user)
    }
    
}
