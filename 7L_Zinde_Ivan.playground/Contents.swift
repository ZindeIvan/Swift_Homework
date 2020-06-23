import Foundation

// Перечисление марок автомобилей
enum Manufacturer : String{
    case toyota = "Toyota"
    case ford   = "Ford"
    case honda  = "Honda"
}

// Перечисление типов топлива
enum FuelType : String{
    case premium = "Premium"
    case regular = "Regular"
    case diesel = "DF"
}

// Перечисление ошибок автомобиля
enum CarErrors : Error{
    case carIsFull
    case wrongFuelType
    case engineStateError
    case windowsStateErrors
}

// Класс автомобиль
class Car {
    //Производитель
    let manufacturer : Manufacturer
    //Дизельный автомобиль
    var dieselCar : Bool = false
    //Максимальный уровень топлива
    let maxFuelLevel : Double
    //Текущий уровень топлива
    var currentFuelLevel : Double = 0
    //Двигатель включен
    var engineOn : Bool = false
    //Окна открыты
    var windowsAreOpen : Bool = false
    
    //Метод заправки автомобиля fuelValue - количество топлива; fuelType - тип топлива
    func fillUpCar (fuelValue: Double, fuelType: FuelType) throws {
        //Проверим если автомобиль дизельный и пытаемся заправить не диз. топливом - вернем ошибку
        guard (dieselCar && fuelType == .diesel) || !dieselCar else {
            throw CarErrors.wrongFuelType
        }
        //Проверим если максимальный уровень топлива меньше текущего уровня топлива
        // + топливо которое заправляем - вернем ошибку
        guard maxFuelLevel >= currentFuelLevel + fuelValue else {
            throw CarErrors.carIsFull
        }
        
        //Увеличим текущий уровень топлива
        self .currentFuelLevel += fuelValue
    }
    
    //Функция включения / выключения двигателя - при указании turnOn в значение True включается двигатель и при False выключается
    func changeEngineState(turnOn : Bool = true) -> (String?, Error?){
        //Проверяем если текущее состояние двигателя соответсвует действию вернем ошибку
        guard self .engineOn != turnOn  else {
            return (nil, CarErrors.engineStateError)
        }
        self .engineOn = turnOn
        return ("Двигатель \(self .engineOn ? "запущен" : "заглушен")", nil);
    }
    
    //Функция открытия / закрытия окон - при указании open в значение True окна открываются и при False закрываются
    func changeWindowsState(open : Bool = true) -> (String?, Error?){
        //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
        guard self .windowsAreOpen != open else {
            return (nil, CarErrors.windowsStateErrors)
        }
        
        self .windowsAreOpen = open
        return ("Окна \(self .windowsAreOpen ? "опущены" : "подняты")", nil)
    }
    
    //Конструктор по производителю
    init (manufacturer : Manufacturer){
        self .manufacturer = manufacturer
        switch manufacturer {
        case .ford:
            dieselCar = true
            maxFuelLevel = 55
        case .honda:
            maxFuelLevel = 50
            currentFuelLevel = 30
        case .toyota:
            maxFuelLevel = 45
            currentFuelLevel = 15
        }
    }
}

//Перечисление ошибок заправочной станции
enum GasStationErrors : Error {
    case invalideFuelType
    case outOfFuel
    case insufficientFunds
}

//Структура топлива на заправочной станции
struct GasStationFuel {
    var price : Double
    var value : Double
    let fuelType : FuelType
}

//Класс заправочная станция
class GasStation {
    //Хранилище топлива
    var fuelStorage = [
        "Premium" : GasStationFuel(price: 0.44, value: 2000, fuelType: .premium),
        "Regular" : GasStationFuel(price: 0.38, value: 10, fuelType: .regular),
        "DF" : GasStationFuel(price: 0.46, value: 1000, fuelType: .diesel),
    ]
    
    //Метод заправки автомобиля
    func fillTheCar(car: Car, money: Double, fuelValue: Double, fuelType: String) throws -> String{
        //Проверим есть ли данное топливо на станции, если нет - вернем ошибку
        guard var fuel = fuelStorage[fuelType] else {
            throw GasStationErrors.invalideFuelType
        }
        //Проверим есть ли данное количество указанного топлива на станции, если нет - вернем ошибку
        guard fuel.value >= fuelValue else {
            throw GasStationErrors.outOfFuel
        }
        //Проверим хватает ли денег для заправки данного количества топлива - вернем ошибку
        guard fuel.price * fuelValue <= money else {
            throw GasStationErrors.insufficientFunds
        }
        //Вызовем метод заправки автомобиля данным типом топлива, в заданном количестве
        try car.fillUpCar(fuelValue: fuelValue, fuelType: fuel.fuelType)
        //Уменьшим количество топлива в хранилище
        fuel.value -= fuelValue
        gasStation.fuelStorage[fuelType] = fuel
        //Вернем результат выполнения строкой
        return "Машина \(car.manufacturer.rawValue) заправлена топливом \(fuelType) на \(fuelValue) литров, сдача \(money - fuel.price * fuelValue)"
    }
}

//Обработка ошибка через кортеж (Any?, Error?)
var hondaCar = Car(manufacturer: .honda)
let firstEngineAction = hondaCar.changeEngineState()
if let result = firstEngineAction.0 {
    print(result)
} else if let error = firstEngineAction.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}

let secondEngineAction = hondaCar.changeEngineState()
if let result = secondEngineAction.0 {
    print(result)
} else if let error = secondEngineAction.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}

let firstWindowsAction = hondaCar.changeWindowsState(open: false)
if let result = firstWindowsAction.0 {
    print(result)
} else if let error = firstWindowsAction.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}

let secondWindowsAction = hondaCar.changeWindowsState()
if let result = secondWindowsAction.0 {
    print(result)
} else if let error = secondWindowsAction.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}

print()
print("---------------------------------")

//Обработка ошибка через throw Try/Catch
//Функция вызова метода заправочной станции
func executeGasStationAction(car: Car, money: Double, fuelValue: Double, fuelType: String){
    
    do {
        let result = try gasStation.fillTheCar(car: car, money: money, fuelValue: fuelValue, fuelType: fuelType)
        print(result)
    } catch GasStationErrors.invalideFuelType  {
        print("Нет такого топлива")
    } catch GasStationErrors.insufficientFunds {
        print("Недостаточно денег")
    } catch GasStationErrors.outOfFuel {
        print("Недостаточное количество топлива на заправочной станции")
    } catch CarErrors.wrongFuelType {
        print("Не верный тип топлива для автомобиля")
    } catch CarErrors.carIsFull {
        print("Переполнение топливного бака автомобиля")
    } catch let error {
        print("Произошла ошибка: \(error.localizedDescription)")
    }
}

let gasStation = GasStation()
var fordCar = Car(manufacturer: .ford)
executeGasStationAction(car: fordCar, money: 1000, fuelValue: 55, fuelType: "Premium")
executeGasStationAction(car: fordCar, money: 10, fuelValue: 55, fuelType: "DF")
executeGasStationAction(car: fordCar, money: 200, fuelValue: 55, fuelType: "DF")
executeGasStationAction(car: fordCar, money: 300, fuelValue: 10, fuelType: "DF")

print()

var toyotaCar = Car(manufacturer: .toyota)
executeGasStationAction(car: toyotaCar, money: 1000, fuelValue: 55, fuelType: "ExtraPremium")
executeGasStationAction(car: toyotaCar, money: 1000, fuelValue: 20, fuelType: "Regular")
executeGasStationAction(car: toyotaCar, money: 50, fuelValue: 20, fuelType: "Premium")
