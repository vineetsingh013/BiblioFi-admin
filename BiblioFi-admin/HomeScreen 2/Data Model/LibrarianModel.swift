//
//  LibrarianModel.swift
//  BiblioFi-admin
//
//  Created by Keshav Lohiya on 04/07/24.
//

import Foundation

struct Librarian: Identifiable, Codable {
    let id: String
    var name: String
    var email: String
    var phoneNumber: String
    var address: String
    

    init(id: String, name: String, email: String, phoneNumber: String, address: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.address = try container.decode(String.self, forKey: .address)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case email
        case phoneNumber
        case address
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
        try container.encode(self.address, forKey: .address)
    }
}
