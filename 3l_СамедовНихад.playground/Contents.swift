struct Car {
    enum CarType: String {
        case sport = "легковой"
        case trunk = "грузовик"
    }
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
    
    var type: CarType
    var engine: EngineState
    var windows: WindowsState
    var brand: String
    var releaseYear: String
    var speed: String {
        get {
            if type == .sport {
                return "90км/ч"
            } else {
                return "60км/ч"
            }
        }
    }
    var baggageCapacity: Double {
        get {
            if type == .sport {
                return 30
            } else {
                return 100
            }
        }
    }
    var baggageFilled: Double {
        didSet {
            print("Места в багаже осталось: \(baggageCapacity - baggageFilled)")
        }
    }
    
    init() {
        type = .trunk
        engine = .off
        windows = .closed
        brand = "unknown"
        releaseYear = "unknown"
        baggageFilled = 0
    }
    
    init(type: CarType, brand: String, releaseYear: String) {
        self.init()
        self.type = type
        self.brand = brand
        self.releaseYear = releaseYear
    }
    
    mutating func addToBaggage(kg: Double) {
        guard kg + baggageFilled <= baggageCapacity else { print("Недостаточно места в багаже"); return }
        baggageFilled += kg
    }
    
    mutating func takeOutOfBaggage(kg: Double) {
        if baggageFilled - kg < 0 {
            baggageFilled = 0
        } else {
            baggageFilled -= kg
        }
    }
    
    mutating func setEngineState(state: EngineState) {
        engine = state
    }
    
    func displayDetails() {
        print("Тип машины: \(type.rawValue)")
        print("Бренд: \(brand)")
        print("Год выпуска: \(releaseYear)")
        print("Скорость: \(speed)")
        print("Объем багажа: \(baggageCapacity). Заполнено: \(baggageFilled)")
    }
}

var trunkCar = Car(type: .trunk, brand: "Volvo truck", releaseYear: "1992")
trunkCar.addToBaggage(kg: 90)
trunkCar.addToBaggage(kg: 11)
trunkCar.engine.turnOn()
trunkCar.windows.open()
trunkCar.setEngineState(state: .off)
trunkCar.takeOutOfBaggage(kg: 50)
trunkCar.displayDetails()

var sportCar = Car(type: .sport, brand: "Tesla", releaseYear: "2012")
sportCar.displayDetails()



