//
//  LibrarianDataController.swift
//  BiblioFi-admin
//
//  Created by Akshat Kamboj on 04/07/24.
//

import Foundation

class LibrarianController: ObservableObject {
    //    @Published var librarians: [Librarian] = []
    
    @Published var librarian: Librarian?
    @Published var errorMessage: String?
    
    func fetchLibrarian(withId id: String) {
        LibrarianManager.shared.fetchLibrarian(withId: id) { result in
            switch result {
            case .success(let librarian):
                DispatchQueue.main.async {
                    self.librarian = librarian
                    self.errorMessage = nil
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.librarian = nil
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func addLibrarian(name: String, email: String, phoneNumber: String, address: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.createLibrarian(email: email, password: password)
            
                DispatchQueue.main.async {
                    let newLibrarian = Librarian(id: authDataResult.uid, name: name, email: authDataResult.email!, phoneNumber: phoneNumber, address: address)
                    //                    self.librarians.append(newLibrarian)
                    UserDefaults.standard.setValue(authDataResult.uid, forKey: "LibrarianID")
                    print(newLibrarian)
                    LibrarianManager.shared.addLibrarian(librarian: newLibrarian, completion: completion)
                }
            } catch {
                print("error at adding librarian!")
            }
        }
        
    }
    
    
}
