import Foundation

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
    //Двигатель включен
    var engineOn : Bool { get set }
    //Окна открыты
    var windowsAreOpen : Bool { get set }
    
    //Функция действий с автомобилем
    func executeCarAction(action : Actions)

}

//Расширения стандартных действий для всех объектов имплементирующих протокол CarActionExecutable
extension  CarActionExecutable {
    
    //Функция включения / выключения двигателя - при указании turnOn в значение True включается двигатель и при False выключается
    mutating func changeEngineState(turnOn : Bool = true){
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
    
    //Метод дествий с цистерной
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
    

    //Конструктор на основе производителя
    init (manufacturer : Manufacturer){
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
    }
}

//Расширение имплементирующее протокол CustomStringConvertible
extension TunkCar : CustomStringConvertible {
    
    var description: String {
        return  "Данные цистерны: \n" +
                "   Производитель: \(manufacturer.rawValue)\n" +
                "   Год выпуска: \(modelYear)\n" +
                "   Максимальный объем цистерны: \(tunkMaxCapacity)\n" +
                "   Количество колес: \(wheelsCount)\n" +
                "Состояние автомобиля:\n" +
                "   Двигатель \(engineOn ? "запущен" : "заглушен")\n" +
                "   Окна \(windowsAreOpen ? "открыты" : "закрыты")\n" +
                "   Цистерна заполнена на: \(tunkCurrentCapasity)"
    }
}

//Создадим перечисление материалов люка спортивного автомобиля
enum HatchMaterial : String{
    case glass = "Стекло"
    case carbon = "Углепластик"
    case metal = "Металл"
}

//Создадим класс спортивный автомобиль - наследник класса автомобиль
class SportCar : CarActionExecutable {
    //Производитель
    let manufacturer : Manufacturer
    //Год выпуска
    let modelYear : UInt
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
    //Материал люка
    let hatchMaterial : HatchMaterial
    //Люк открыт
    var hatchIsOpen : Bool = false{
        didSet {
            print("Люк \(oldValue ? "закрыт" : "открыт")")
        }
    }
    //Турбо режим включен
    var turboOn : Bool = false{
        didSet {
            print("Турбо режим \(oldValue ? "выключен" : "включен")")
        }
    }

    //Метод действий с автомобилем
    func executeCarAction(action: Actions) {

        switch action{

        case let .hatchAction(open) :
            //Проверим если люк уже открыт выведем ошибку
            guard self .hatchIsOpen != open else { print("Люк уже \(self .hatchIsOpen ? "открыт" : "закрыт")"); return }

            self .hatchIsOpen = open

        case let .turboAction(turnOn) :
            //Проверим если турбо режим уже включен выведем ошибку
            guard self .turboOn != turnOn else { print("Турбо режим уже \(self .turboOn ? "включен" : "выключен")"); return }

            self .turboOn = turnOn

        default :
            print("Данное действие не поддерживается!")
            return
        }
    }

    //Конструктор на основе производителя и материала люка
    init (manufacturer : Manufacturer, hatchMatireal : HatchMaterial){
        switch manufacturer {
        case .toyota:
            modelYear = 2018
        case .ford:
            modelYear = 2020
        case .honda:
            modelYear = 2019
        }
        
        self .manufacturer = manufacturer
        self .hatchMaterial = hatchMatireal
    }

}

//Расширение имплементирующее протокол CustomStringConvertible
extension SportCar : CustomStringConvertible {
    
    var description: String {
        return  "Данные цистерны:\n" +
                "   Производитель: \(manufacturer.rawValue)\n" +
                "   Год выпуска: \(modelYear)\n" +
                "   Материал люка: \(hatchMaterial.rawValue)\n" +
                "Состояние автомобиля:\n" +
                "   Двигатель \(engineOn ? "запущен" : "заглушен")\n" +
                "   Окна \(windowsAreOpen ? "открыты" : "закрыты")\n" +
                "   Турбо режим \(turboOn ? "включен" : "выключен")\n" +
                "   Люк \(hatchIsOpen ? "открыт" : "закрыт")"
    }
}

//Создадим переменную класса грузовой автомобиль
var fordTunck = TunkCar(manufacturer: .ford)
//Выведем значение свойств грузовика
print(fordTunck)
//Опустим / поднимем окна
fordTunck.changeWindowsState()
fordTunck.changeWindowsState()
fordTunck.changeWindowsState(open: false)
//Запустим двигатель
fordTunck.changeEngineState()
//Заполним цистерну
fordTunck.executeCarAction(action: .tunkAction(value: 750))

print()

//Создадим еще одну переменную класса грузовой автомобиль
var toyotaTunck = TunkCar(manufacturer: .toyota)
//Выведем значение свойств грузовика
print(toyotaTunck)
//Запустим двигатель
toyotaTunck.changeEngineState()
//Заполним / сольем цистерну
toyotaTunck.executeCarAction(action: .tunkAction(value: 2000))
toyotaTunck.executeCarAction(action: .tunkAction(value: 100))
toyotaTunck.executeCarAction(action: .tunkAction(value: 100, fill: false))

print()
print("-----------------------------------------------------------------")

//Создадим переменную класса спортивный автомобиль
var hondaSport = SportCar(manufacturer: .honda, hatchMatireal: .carbon)
//Выведем значение свойств спортивного автомобиля
print(hondaSport)
//Откроем / закроем люк
hondaSport.executeCarAction(action: .hatchAction())
hondaSport.executeCarAction(action: .hatchAction(open: false))
//Запустим двигатель
hondaSport.changeEngineState()
//Включим / выключим турбо режим
hondaSport.executeCarAction(action: .turboAction())
hondaSport.executeCarAction(action: .turboAction())
hondaSport.executeCarAction(action: .turboAction(turnOn: false))
//Опустим окна
hondaSport.changeWindowsState()

print()

//Создадим еще одну переменную класса спортивный автомобиль
var toyotaSport = SportCar(manufacturer: .toyota, hatchMatireal: .glass)
//Выведем значение свойств спортивного автомобиля
print(toyotaSport)
//Откроем люк
toyotaSport.executeCarAction(action: .hatchAction())
//Откроем окна
toyotaSport.changeWindowsState()
//Запустим двигатель
toyotaSport.changeEngineState()
