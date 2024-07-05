import Foundation

struct All {
    let admin: Admin
    let members: [Member]
    let books: [Book]
}

struct Admin {
    let id: String
    let email: String?
    let library : Library?
}

struct Member {
    let id: String
    let joinedDate: [Date]?
    let name: String?
    let email: String?
    let phoneNumber: String?
    let age: Int?
    let issuedBooks: [Book]?
    let reservedBooks: [Book]?
    let totalFine: Int?
    let pastFines: [Int]?
    let issuedBooksHistory: [Book]?
    let wishlist: [Book]?
}

struct Book {
    let id: String
    let title: String?
    let author: String?
    let cover: String?
    let isbn10: String?
    let isbn13: String?
    let category: String?
    let publisher: String?
    let description: String?
    let pages: Int?
    let eBook: String?
    let rating: Int?
    let count: Int?
}

struct IssuedBooks{
    let id: String
    let bookId: String
    let userId: String?
    let issueDate: Date?
    let returnDate: Date?
    
}

struct AudioBook {
    
}

struct Library{
    let librarian : librarian
    let books : [Book]
    let members : [Member]
}

struct librarian: Codable{
    let id: String
    var name: String?
    var password: String?
    var email: String?
    var phoneNumber: String?
    var address: String?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.password = try container.decodeIfPresent(String.self, forKey: .password)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
    }
    enum CodingKeys: CodingKey {
        case id
        case name
        case password
        case email
        case phoneNumber
        case address
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.password, forKey: .password)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(self.address, forKey: .address)
    }
}
