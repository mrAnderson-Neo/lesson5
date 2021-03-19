//
//  main.swift
//  lesson5
//
//  Created by Андрей Калюжный on 18.03.2021.
//

import Foundation

// MARK:- ++Перечисления
enum EngineConditions: String {
    case launched = "Заупщен"
    case switchedOff = "Выключен"
}

enum DoorsConditions: String {
    case open = "Дверь открыта"
    case close = "Дверь закрыта"
}

enum WindowsConditions: String {
    case open = "Окно открыто"
    case close = "Окно закрыто"
}
// MARK:- -- Перечисления


// MARK:- ++Протокол Car
protocol Car: class {
    var windowCondition: WindowsConditions{get set}
    var engineCondition: EngineConditions{get set}
    var doorCondition: DoorsConditions{get set}
    
    func startTheEngine()
    func turnOffTheEngine()
    func openTheDoor()
    func closeTheDoor()
}

extension Car {
    var engineCondition: EngineConditions {
        return .switchedOff
    }
    
    var doorCondition: DoorsConditions {
        return .close
    }
    
    func startTheEngine() {
        engineCondition = .launched
    }
    
    func turnOffTheEngine() {
        engineCondition = .switchedOff
    }
    
    func openTheDoor() {
        doorCondition = .open
    }
    
    func closeTheDoor() {
        doorCondition = .close
    }
    
    func getInfoCar() -> String {
        return """
            Состояние окон: \(windowCondition.rawValue)
            Состяние двигателя: \(engineCondition.rawValue)
            Состяние дверей: \(doorCondition.rawValue)
            """
    }
}

// --Протокол Car


// MARK:- ++Классы
class SportCar: Car {
    var doorCondition: DoorsConditions
    var engineCondition: EngineConditions
    var windowCondition: WindowsConditions
    var hingedRoof: RoofConditions{
        didSet {
            print(hingedRoof.rawValue)
        }
        willSet {
            switch newValue {
            case .open:
                print("Происходит открытие крыши")
            case .close:
                print("Происходит закрытие крыши")
            }
        }
    }
    
    enum RoofConditions: String {
        case open = "крыша открыта"
        case close = "крыша закрыта"
    }
    
    init(doorCondition: DoorsConditions, engineCondition: EngineConditions, windowCondition: WindowsConditions, hingedRoof: RoofConditions) {
        self.windowCondition = windowCondition
        self.engineCondition = engineCondition
        self.doorCondition = doorCondition
        self.hingedRoof = hingedRoof
    }
}

class TrunkCar: Car {
    var doorCondition: DoorsConditions
    var engineCondition: EngineConditions
    var windowCondition: WindowsConditions
    let carWeigth: Float
    private var cargoWeigth: Float = 0
    var totalWeigth: Float {
        get {
            return carWeigth + cargoWeigth
        }
    }
    
    init(doorCondition: DoorsConditions, engineCondition: EngineConditions, windowCondition: WindowsConditions, carWeigth: Float) {
        self.windowCondition = windowCondition
        self.engineCondition = engineCondition
        self.doorCondition = doorCondition
        self.carWeigth = carWeigth
    }
    
    func attachUncloupleTheTrailer(_ cargoWeigth: Float){
        self.cargoWeigth = cargoWeigth
    }
    
    func setcargoWeigth(_ cargoWeigth: Float) {
        self.cargoWeigth = cargoWeigth
    }
}

// --Классы


//MARK:- ++Расширения класса
extension SportCar: CustomStringConvertible {
    var description: String {
        return getInfoCar() +
            """
            \nСостояние крыши: \(hingedRoof.rawValue)
            """
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return getInfoCar() +
            """
            \nВес автомобиля: \(carWeigth) тонн(ы)
            Вес прицепа: \(cargoWeigth) тонн(ы)
            Общий вес: \(totalWeigth) тонн(ы)
            """
    }
}

// --Расширения класса

//MARK:- ++Создаём объекты классов

let separator = "========================"

var sportCar = SportCar(doorCondition: .close, engineCondition: .switchedOff, windowCondition: .close, hingedRoof: .open)
sportCar.hingedRoof = SportCar.RoofConditions.close
print(separator)
print(sportCar)

print(separator)

var trunkCar = TrunkCar(doorCondition: .close, engineCondition: .switchedOff, windowCondition: .open, carWeigth: 10.5)
trunkCar.setcargoWeigth(2.8)
print(trunkCar)
