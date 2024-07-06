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
    let librarian : Librarian
    let books : [Book]
    let members : [Member]
}

