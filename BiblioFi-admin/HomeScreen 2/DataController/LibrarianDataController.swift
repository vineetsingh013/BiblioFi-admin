//
//  LibrarianDataController.swift
//  BiblioFi-admin
//
//  Created by Akshat Kamboj on 04/07/24.
//

import Foundation

class LibrarianController: ObservableObject {
    @Published var librarians: [Librarian] = []
    
    func addLibrarian(name: String, email: String, phoneNumber: String, address: String) {
        let newLibrarian = Librarian(id: UUID(), name: name, email: email, phoneNumber: phoneNumber, address: address)
        librarians.append(newLibrarian)
    }
    
    func deleteLibrarian(at index: Int) {
        librarians.remove(at: index)
    }
}
