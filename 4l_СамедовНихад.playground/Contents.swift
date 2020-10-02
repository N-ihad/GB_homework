class Car {
    var engine: EngineState
    var windows: WindowsState
    var brand: String
    var releaseYear: String
    var speed: String {
        get { "70 км/ч "}
    }
    var baggageCapacity: Double {
        get { 50 }
    }
    var baggageFilled: Double {
        didSet {
            print("*** Места в багаже осталось: \(baggageCapacity - baggageFilled) ***")
        }
    }

    init() {
        engine = .off
        windows = .closed
        brand = ""
        releaseYear = ""
        baggageFilled = 0
    }

    convenience init(brand: String, releaseYear: String) {
        self.init()
        self.brand = brand
        self.releaseYear = releaseYear
    }

    func addToBaggage(kg: Double) {
        guard kg + baggageFilled <= baggageCapacity else { print("*** Недостаточно места в багаже ***"); return }
        baggageFilled += kg
    }

    func takeOutOfBaggage(kg: Double) {
        if baggageFilled - kg < 0 {
            baggageFilled = 0
        } else {
            baggageFilled -= kg
        }
    }

    func setEngineState(state: EngineState) {
        engine = state
    }
    
    func enterRaceCompetition() -> Bool {
        return false
    }

    func displayDetails() {
        print("Бренд: \(brand)")
        print("Год выпуска: \(releaseYear)")
        print("Скорость: \(speed)")
        print("Объем багажа: \(baggageCapacity). Заполнено: \(baggageFilled)")
    }
}

class SportCar: Car {
    
    var numberOfPeopleCanCarry: Int
    var sunRoofWindow: SunRoofWindow
    
    override var speed: String {
        get { "90 км/ч" }
    }
    
    override var baggageCapacity: Double {
        get { 200 }
    }
    
    init(brand: String, releaseYear: String, numberOfPeopleCanCarry: Int, hasSunRoofWindow: Bool) {
        self.numberOfPeopleCanCarry = numberOfPeopleCanCarry
        self.sunRoofWindow = hasSunRoofWindow ? .closed : .noSunRoofWindow
        super.init()
        self.brand = brand
        self.releaseYear = releaseYear
    }
    
    override func enterRaceCompetition() -> Bool {
        guard baggageFilled == 0 else { print("*** Can't enter the competition. Baggage space should be emptied. ***"); return false }
        print("*** Entered the race ***")
        return true
    }
    
    func openSunRoofWindow() {
        if sunRoofWindow == .noSunRoofWindow {
            print("*** Car doesn't have sun roof window ***")
        } else {
            sunRoofWindow = .open
        }
    }
    
    func closeSunRoofWindow() {
        if sunRoofWindow == .noSunRoofWindow {
            print("*** Car doesn't have sun roof window ***")
        } else {
            sunRoofWindow = .closed
        }
    }
    
    func displaySportCarDetails() {
        super.displayDetails()
        print("Максимальное количество людей: \(numberOfPeopleCanCarry)")
        print("Панорамная крыша: \(sunRoofWindow)")
    }
}

class TrunkCar: Car {
    
    var trailer: Trailer

    
    override var speed: String {
        get { "60 км/ч" }
    }
    
    override var baggageCapacity: Double {
        get { 20000 }
    }
    
    override func enterRaceCompetition() -> Bool {
        print("*** This type of car cannot enter the race competition ***")
        return false
    }
    
    func carryCargo(kg: Double) {
        switch kg {
        case 0..<5000:
            break
        case 5000..<10000:
            if trailer.size == .short { print("*** Trailer too short to carry the cargo ***"); return }
        case 10000..<20000:
            if trailer.size == .short || trailer.size == .medium { print("*** Trailer too short to carry the cargo ***"); return }
        default:
            print("Something went wrong")
        }
        addToBaggage(kg: kg)
        print("*** Cargo has been loaded onto trailer ***")
    }
    
    func loadFoodIntoTrailer(kg: Double) {
        guard trailer.kind == .refrigerated else { print("*** Trailer type is not suited for this load ***"); return }
        addToBaggage(kg: kg)
    }
    
    init(brand: String, releaseYear: String, trailerSize: Trailer.Size, trailerType: Trailer.Kind) {
        self.trailer = Trailer(kind: trailerType, size: trailerSize)
        super.init()
        self.brand = brand
        self.releaseYear = releaseYear
    }
    
    func displayTrunkDetails() {
        super.displayDetails()
        print("Тип прицепа: \(trailer.kind)")
        print("Габариты прицепа: \(trailer.size)")
    }
}

extension Car {
    
    enum EngineState {
        case on
        case off

        mutating func turnOn() {
            self = .on
        }

        mutating func turnOff() {
            self = .off
        }
    }
    
    enum WindowsState {
        case opened
        case closed

        mutating func open() {
            self = .opened
        }

        mutating func close() {
            self = .closed
        }
    }
}

extension SportCar {
    
    enum SunRoofWindow: String {
        case open = "открыто"
        case closed = "закрыто"
        case noSunRoofWindow = "нету"
    }
    
}

extension TrunkCar {
    
    struct Trailer {
        
        enum Kind {
            case straight
            case dryVan
            case conestoga
            case refrigerated
            case specialized
        }
        
        enum Size {
            case short
            case medium
            case long
        }
        
        var kind: Kind
        var size: Size
    }
    
}

var trunkCar = TrunkCar(brand: "Volvo Truck", releaseYear: "1993", trailerSize: .short, trailerType: .conestoga)
trunkCar.addToBaggage(kg: 90)
trunkCar.addToBaggage(kg: 11)
trunkCar.engine.turnOn()
trunkCar.windows.open()
trunkCar.setEngineState(state: .off)
trunkCar.takeOutOfBaggage(kg: 50)
trunkCar.carryCargo(kg: 4000)
trunkCar.loadFoodIntoTrailer(kg: 200)
trunkCar.displayTrunkDetails()

print("\n")
var sportCar = SportCar(brand: "McLaren", releaseYear: "2000", numberOfPeopleCanCarry: 2, hasSunRoofWindow: true)
sportCar.enterRaceCompetition()
sportCar.openSunRoofWindow()
sportCar.closeSunRoofWindow()
sportCar.displaySportCarDetails()

