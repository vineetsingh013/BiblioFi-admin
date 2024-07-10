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

struct librarian{
    
}

struct LibraryStats {
    let totalUsers: Int
    let totalBooks: Int
    let fineDue: Double
    let userActivity: [String: Int] // Day of the week -> Activity count
    let monthlyRevenue: [String: Double] // Month -> Revenue
    let trendingBooks: [TrendingBook]
}

struct TrendingBook {
    let category: String
    let issuedCount: Int
    let percentageOfTotal: Double
}


let sampleLibraryStats = LibraryStats(
    totalUsers: 2435,
    totalBooks: 3276,
    fineDue: 1763.0,
    userActivity: ["Mon": 30, "Tue": 40, "Wed": 80, "Thu": 100, "Fri": 75, "Sat": 60, "Sun": 23],
    monthlyRevenue: ["March": 1200.0, "April": 7200.0, "May": 3600.0],
    trendingBooks: [
        TrendingBook(category: "Fantasy", issuedCount: 78, percentageOfTotal: 45.0),
        TrendingBook(category: "Fiction", issuedCount: 78, percentageOfTotal: 45.0),
        TrendingBook(category: "Politics", issuedCount: 78, percentageOfTotal: 45.0)
    ]
)
