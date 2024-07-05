//
//  LibrarianModel.swift
//  BiblioFi-admin
//
//  Created by Keshav Lohiya on 04/07/24.
//

import Foundation

struct Librarian: Identifiable {
    let id: UUID
    var name: String
    var email: String
    var phoneNumber: String
    var address: String
}
