import Foundation
import UIKit

// Создадим перечисление марок автомобилей/цистерн
enum Manufacturer : String{
    case toyota = "Toyota"
    case ford   = "Ford"
    case honda  = "Honda"
}

// Создадим перечисление возможных действий с цистернами/спорткарами
enum Actions {

    //Действие с кузовом - value - количество топлива(жидкости); при указании fill в значение True заправляем цистерну и при False сливаем из цистерны
    case tunkAction (value : Double, fill : Bool = true)
    //Действие с турбо режимом - при указании turnOn в значение True включаем турбо режим и при False выключаем
    case turboAction (turnOn : Bool = true)
    //Действие с люком - при указании open в значение True открываем люк и при False закрываем
    case hatchAction (open : Bool = true)

}

// Создадим протокол для автомобилей
protocol CarActionExecutable {
    //Производитель
    var manufacturer : Manufacturer { get }
    //Год выпуска
    var modelYear : UInt { get }
    //Цвет автомобиля
    var color : UIColor { get set }
    //Двигатель включен
    var engineOn : Bool { get set }
    //Окна открыты
    var windowsAreOpen : Bool { get set }
    
    //Функция дествий с атомобилем
    func executeCarAction(action : Actions)

}

//Расширения стандартных действий для всех объектов имплементирующих протокол CarActionExecutable
extension  CarActionExecutable {
    
    //Функция включения / выключения двигателя - при указании turnOn в значение True включается двигатель и при False выключается
    mutating func changeEngineState(turnOn : Bool){
        //Проверяем если текущее состояние двигателя соответсвует действию выводим ошибку
        guard self .engineOn != turnOn  else { print("Двигатель уже \(self .engineOn ? "запущен" : "заглушен")"); return }
        
        self .engineOn = turnOn
    }
    
    //Функция открытия / закрытия окон - при указании open в значение True окна открываются и при False закрываются
    mutating func changeWindowsState(open : Bool = true){
        //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
        guard self .windowsAreOpen != open else { print("Окна уже \(self .windowsAreOpen ? "опущены" : "подняты")"); return}
        
        self .windowsAreOpen = open
    }

}

//Создадим класс автомобиль цистерну - наследник класса автомобиль
class TunkCar :  CarActionExecutable {

    //Производитель
    let manufacturer : Manufacturer
    //Год выпуска
    let modelYear : UInt
    //Цвет автомобиля
    var color : UIColor
    //Двигатель включен
    var engineOn : Bool = false{
        didSet {
            print("Двигатель \(oldValue ? "заглушен" : "запущен")")
        }
    }
    //Окна открыты
    var windowsAreOpen : Bool = false{
        didSet {
            print("Окна  \(oldValue ? "закрыты" : "открыты")")
        }
    }
    //Количество колес
    let wheelsCount : Int
    //Максимальный объем цистерны
    let tunkMaxCapacity : Double
    //Текущий объем груза в багажнике
    var tunkCurrentCapasity : Double = 0{
        didSet {
            if tunkMaxCapacity == tunkCurrentCapasity{
                print("Цистерна заправлена полностью")
            }
            else if tunkCurrentCapasity == 0{
                print("Цистерна пустая")
            }
            else {
                print("Цистерна заполнена на \(tunkCurrentCapasity)")
            }
        }
    }
    
    //Функция дествий с цистерной
    func executeCarAction(action : Actions) {
        switch action{
            
        case let .tunkAction(value, fill) :
            if fill {
                //Проверяем если количество топлива(жидкости) привышает максимальный объем выводим ошибку
                guard self .tunkCurrentCapasity + value <= tunkMaxCapacity else { print("Такое количество не войдет в цистерну!"); return }
                
                self .tunkCurrentCapasity += value
            }
            else {
                //Проверяем если количество топлива(жидкости) меньше чем количество которое пытаемся слить и выводим ошибку
                guard self .tunkCurrentCapasity >= value  else { print("В цистерне нет такого количества топлива(жидкости)!"); return}
                
                self .tunkCurrentCapasity -= value
                
            }
            
        default :
            print("Данное действие не поддерживается!")
            return
        }
    }
    

    //Конструктор на основе производителя и цвета
    init (manufacturer : Manufacturer, color : UIColor){
        switch manufacturer {
        case .toyota:
            modelYear = 2010
            tunkMaxCapacity = 2000
            wheelsCount = 6
        case .ford:
            modelYear = 2012
            tunkMaxCapacity = 1500
            wheelsCount = 4
        case .honda:
            modelYear = 2018
            tunkMaxCapacity = 2500
            wheelsCount  = 6
        }
        self .manufacturer = manufacturer
        self .color = color
    }
}


//// Создадим класс Автомобиль
//class Car {
//    //Производитель
//    let manufacturer : Manufacturer
//    //Год выпуска
//    let modelYear : UInt
//    //Максимальный объем багажника
//    let trunkMaxCapacity : Double
//    //Двигатель включен
//    var engineOn : Bool = false{
//        didSet {
//            print("Двигатель \(oldValue ? "заглушен" : "запущен")")
//        }
//    }
//    //Окна открыты
//    var windowsAreOpen : Bool = false{
//        didSet {
//            print("Окна  \(oldValue ? "закрыты" : "открыты")")
//        }
//    }
//    //Текущий объем груза в багажнике
//    var trunkCurrentCapasity : Double = 0{
//        didSet {
//            if trunkMaxCapacity == trunkCurrentCapasity{
//                 print("Машина загружена полностью")
//             }
//            else if trunkCurrentCapasity == 0{
//                 print("Машина пустая")
//             }
//            else {
//                print("Машина заполнена на \(trunkCurrentCapasity)")
//            }
//        }
//    }
//
//    //Функция дествий с атомобилем
//    func executeCarAction(action : Actions){
//
//        switch action{
//
//        case let .engineAction(turnOn) :
//            //Проверяем если текущее состояние двигателя соответсвует действию выводим ошибку
//            guard self .engineOn != turnOn  else { print("Двигатель уже \(self .engineOn ? "запущен" : "заглушен")"); return }
//
//            self .engineOn = turnOn
//
//        case let .windowsAction(open) :
//            //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
//            guard self .windowsAreOpen != open else { print("Окна уже \(self .windowsAreOpen ? "опущены" : "подняты")"); return}
//
//            self .windowsAreOpen = open
//
//        case let .cargoAction(cargoValue, load):
//            if load {
//                //Проверяем если количество груза привышает максимальный объем выводим ошибку
//                guard self .trunkCurrentCapasity + cargoValue <= trunkMaxCapacity else { print("Такое количество груза не войдет в машину!"); return }
//
//                self .trunkCurrentCapasity += cargoValue
//            }
//            else {
//                //Проверяем если количество груза меньше чем количество которое пытаемся разгрузить и выводим ошибку
//                guard self .trunkCurrentCapasity >= cargoValue  else { print("В машине нет такого количества груза!"); return}
//
//                self .trunkCurrentCapasity -= cargoValue
//
//            }
//        default :
//           return
//        }
//    }
//
//    //Функция вывода свойств и состояний автомобиля
//    func printCarValues(){
//        print("Данные автомобиля:")
//        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем багажника: \(trunkMaxCapacity)")
//        print("Состояние автомобиля:")
//        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Багажник заполнен на: \(trunkCurrentCapasity)")
//    }
//
//    //Конструктор в зависимости от модели автомобиля
//    init (manufacturer : Manufacturer){
//        switch manufacturer {
//        case .toyota:
//            modelYear = 2010
//            trunkMaxCapacity = 100
//        case .ford:
//            modelYear = 2012
//            trunkMaxCapacity = 110
//        case .honda:
//            modelYear = 2014
//            trunkMaxCapacity = 80
//        }
//        self .manufacturer = manufacturer
//    }
//}
//
////Создадим класс грузовой автомобиль - наследник класса автомобиль
//class TrunkCar : Car {
//
//    //Количество колес
//    let wheelsCount : Int
//
//    //Кузов поднят
//    var trunkIsLiftedUp : Bool = false{
//        didSet {
//            print("Кузов \(oldValue ? "опущен" : "поднят")")
//        }
//    }
//
//    //Переопределим метод действий с автомобилем
//    override func executeCarAction(action: Actions) {
//
//        //Вызовем родительский метод
//        super .executeCarAction(action: action)
//
//        switch action{
//
//        case let .trunkAction(liftUp) :
//            //Проверим если кузов уже поднят выведем ошибку
//            guard self .trunkIsLiftedUp != liftUp  else { print("Кузов уже \(self .trunkIsLiftedUp ? "поднят" : "опущен")"); return }
//
//            self .trunkIsLiftedUp = liftUp
//
//        default :
//           return
//        }
//    }
//
//    //Переопределим конструктор на основе производителя
//    override init (manufacturer : Manufacturer){
//        switch manufacturer {
//        case .toyota:
//            wheelsCount = 6
//        case .ford:
//            wheelsCount = 4
//        case .honda:
//           wheelsCount  = 6
//        }
//        //Вызовем родительский конструктор
//        super .init(manufacturer: manufacturer)
//    }
//
//    //Переопределим функцию вывода свойств и состояний автомобиля
//    override func printCarValues() {
//
//        print("Данные грузового автомобиля:")
//        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем кузова: \(trunkMaxCapacity); Количество колес: \(wheelsCount)")
//        print("Состояние автомобиля:")
//        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Кузов заполнен на: \(trunkCurrentCapasity); Кузов \(trunkIsLiftedUp ? "поднят" : "опущен")")
//
//    }
//}
//
////Создадим перечисление материалов люка спортивного автомобиля
//enum HatchMaterial : String{
//    case glass = "Стекло"
//    case carbon = "Углепластик"
//    case metal = "Металл"
//}
//
////Создадим класс спортивный автомобиль - наследник класса автомобиль
//class SportCar : Car {
//    //Материал люка
//    let hatchMaterial : HatchMaterial
//    //Люк открыт
//    var hatchIsOpen : Bool = false{
//        didSet {
//            print("Люк \(oldValue ? "закрыт" : "открыт")")
//        }
//    }
//    //Турбо режим включен
//    var turboOn : Bool = false{
//        didSet {
//            print("Турбо режим \(oldValue ? "выключен" : "включен")")
//        }
//    }
//
//    //Переопределим метод действий с автомобилем
//    override func executeCarAction(action: Actions) {
//        //Вызовем родительский метод
//        super .executeCarAction(action: action)
//
//        switch action{
//
//        case let .hatchAction(open) :
//            //Проверим если люк уже открыт выведем ошибку
//            guard self .hatchIsOpen != open else { print("Люк уже \(self .hatchIsOpen ? "открыт" : "закрыт")"); return }
//
//            self .hatchIsOpen = open
//
//        case let .turboAction(turnOn) :
//            //Проверим если турбо режим уже включен выведем ошибку
//            guard self .turboOn != turnOn else { print("Турбо режим уже \(self .turboOn ? "включен" : "выключен")"); return }
//
//            self .turboOn = turnOn
//
//        default :
//           return
//        }
//    }
//
//    //Переопределим функцию вывода свойств и состояний автомобиля
//    override init (manufacturer : Manufacturer){
//        switch manufacturer {
//        case .toyota:
//            hatchMaterial = .glass
//        case .ford:
//            hatchMaterial = .metal
//        case .honda:
//            hatchMaterial = .carbon
//        }
//        super .init(manufacturer: manufacturer)
//    }
//
//    //Переопределим функцию вывода свойств и состояний автомобиля
//    override func printCarValues() {
//
//        print("Данные спортивного автомобиля:")
//        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем багажника: \(trunkMaxCapacity); Материал люка: \(hatchMaterial.rawValue)")
//        print("Состояние автомобиля:")
//        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Багажник заполнен на: \(trunkCurrentCapasity); Турбо режим \(turboOn ? "включен" : "выключен"); Люк \(hatchIsOpen ? "открыт" : "закрыт")")
//
//    }
//
//}
