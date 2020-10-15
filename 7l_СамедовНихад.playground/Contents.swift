class User: Hashable {
    var name: String = ""
    var borrowedBooks: [Book] = []
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class Book {
    var title = ""
    var author = ""
    var quantity: UInt = 0
    
    init(title: String, author: String, quantity: UInt) {
        self.title = title
        self.author = author
        self.quantity = quantity
    }
}

class Library {
    var books = ["Americanah": Book(title: "Americanah", author: "Adichie", quantity: 5),
                 "Angelmaker": Book(title: "Angelmaker", author: "Harkaway", quantity: 1),
                 "Duplex": Book(title: "Duplex", author: "Davis", quantity: 0)]
    
    var users: Set<User> = [User(name: "Nihad"), User(name: "Eugene")]
    var donatedMoney: Double = 0
    
    func borrowBook(title: String, borrowedBy: User) -> (Book?, LibraryError?) {
        guard let usr = users.first(where: { $0.name == borrowedBy.name }) else { return (nil, .noSuchUser) }
        guard borrowedBy.borrowedBooks.count <= 3 else { return (nil, .tooManyBorrowedBooks) }
        guard let book = books[title] else { return (nil, .noSuchBook) }
        guard book.quantity > 0 else { return (nil, .ranOutOfSuchBook) }
        
        usr.borrowedBooks.append(book)
        book.quantity -= 1
        
        return (book, nil)
    }
    
    func signUp(user: User) throws {
        guard users.first(where: { $0.name == user.name }) == nil else { throw LibraryError.suchUserAlreadyExists }
        users.insert(user)
    }
    
    func donateMoney(amount: Double, currency: Currency) throws {
        guard amount >= 0 else { throw LibraryError.invalidAmountOfMoney }
        guard currency == .RUB else { throw LibraryError.currencyMismatch }
        
        donatedMoney += amount
    }
}

enum LibraryError: Error {
    case noSuchUser
    case suchUserAlreadyExists
    case noSuchBook
    case ranOutOfSuchBook
    case tooManyBorrowedBooks
    case currencyMismatch
    case invalidAmountOfMoney
    
    var localizedDescription: String {
        switch self {
        case .noSuchUser:
            return "Такого пользователя не существует в нашей системе. Зарегистрируйтесь"
        case .suchUserAlreadyExists:
            return "Пользователь с таким именем уже существует, выберите другое имя"
        case .noSuchBook:
            return "Такой книги нет в нашей библиотеке"
        case .ranOutOfSuchBook:
            return "Временно нет в наличии"
        case .tooManyBorrowedBooks:
            return "Вы уже взяли (максимум) 3 книги, чтобы получить новые, верните старые"
        case .currencyMismatch:
            return "К сожалению мы принимаем донаты только в рублях"
        case .invalidAmountOfMoney:
            return "Вы не можете пожертвовать отрицательную сумму"
        }
    }
}

enum Currency {
    case USD
    case RUB
    case CAD
    case AZN
}

var lib = Library()
let user = User(name: "Nihad")

// Регистрация в библиотеке
do {
    try lib.signUp(user: user)
} catch let err as LibraryError {
    print(err.localizedDescription)
}

// Взять книгу с библиотеки
let book = lib.borrowBook(title: "Angelmaker", borrowedBy: user)

if let book = book.0 {
    print("Книга \"\(book.title) - \(book.author)\" успешно взята с библиотеки!")
} else if let err = book.1 {
    print("Ошибка! \(err.localizedDescription)")
}

// Задонатить
do {
    try lib.donateMoney(amount: 100, currency: .USD)
} catch let err as LibraryError {
    print(err.localizedDescription)
}


