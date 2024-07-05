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
    
//    func addLibrarian(librarian: Librarian, completion: @escaping (Result<Void, Error>) -> Void) {
//        do {
//            _ = try librarianCollection().addDocument(from: librarian, completion: { error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            })
//        } catch {
//            completion(.failure(error))
//        }
//    }
    
//    func deleteLibrarian(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        librarianCollection().document(id).delete { error in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    }
//    
//    private func librarianCollection() -> CollectionReference {
//        libraryDocument().collection("Librarian")
//    }
}
