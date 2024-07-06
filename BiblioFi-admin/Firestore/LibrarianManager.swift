//
//  LibrarianManager.swift
//  BiblioFi-admin
//
//  Created by Akshat Kamboj on 05/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class LibrarianManager {
    static let shared = LibrarianManager()
    
    private init() { }
    
    private let adminCollection: CollectionReference = Firestore.firestore().collection("admin")
    
    private func adminDocument() -> DocumentReference {
        adminCollection.document("admin-id")
    }
    
    private func libraryCollection() -> CollectionReference {
        adminDocument().collection("Library")
    }
    
    private func libraryDocument() -> DocumentReference {
        libraryCollection().document("library-id")
    }
    
    func addLibrarian(librarian: Librarian, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try librarianCollection().document(librarian.id).setData(from: librarian, completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        } catch {
            completion(.failure(error))
        }
    }

    
    func deleteLibrarian(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        librarianCollection().document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
        
    func fetchLibrarian(withId id: String, completion: @escaping (Result<Librarian, Error>) -> Void) {
            librarianCollection().document(id).getDocument { document, error in
                if let document = document, document.exists {
                    do {
                        let librarian = try document.data(as: Librarian.self)
                        completion(.success(librarian))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Librarian not found"])))
                }
            }
        } 
    
    private func librarianCollection() -> CollectionReference {
        libraryDocument().collection("Librarian")
    }
}



extension Query {
    func getDocuments2<T>(as type: T.Type) async throws -> [T] where T: Decodable{
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
}
