import Foundation

// Создадим перечисление марок автомобилей/грузовиков
enum Manufacturer : String{
    case toyota = "Toyota"
    case ford   = "Ford"
    case honda  = "Honda"
}

// Создадим перечисление возможных действий с автомобилями/грузовиками
enum Actions {
    //Действие с двигателем - при указании turnOn в значение True включается двигатель и при False выключается
    case engineAction (turnOn : Bool = true)
    //Действие с окнами - при указании open в значение True окна открываются и при False закрываются
    case windowsAction (open : Bool = true)
    //Действие с грузом - cargoValue - количество груза; при указании load в значение True загружаем груз и при False разгружаем
    case cargoAction (cargoValue : Double, load : Bool = true)
}

//Создадим структуру автомобиля
struct Car {
    //Производитель
    let manufacturer : Manufacturer
    //Год выпуска
    let modelYear : UInt
    //Максимальный объем багажника
    let trunkMaxCapacity : Double
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
    //Текущий объем груза в багажнике
    var trunkCurrentCapasity : Double = 0{
        didSet {
            print("Багажник заполнен на \(trunkCurrentCapasity)")
        }
    }
    
    //Функция дествий с атомобилем
    mutating func changeCarState(action : Actions){
        
        switch action{
            
        case let .engineAction(turnOn) :
            //Проверяем если текущее состояние двигателя соответсвует действию выводим ошибку
            if self .engineOn == turnOn {
                print("Двигатель уже \(self .engineOn ? "запущен" : "заглушен")")
            }
            else{
                self .engineOn = turnOn
            }
        case let .windowsAction(open) :
            //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
            if self .windowsAreOpen == open {
                print("Окна уже \(self .windowsAreOpen ? "опущены" : "подняты")")
            }
            else{
                self .windowsAreOpen = open
            }
        case let .cargoAction(cargoValue, load):
            if load {
                //Проверяем если количество груза привышает максимальный объем выводим ошибку
                if  self .trunkCurrentCapasity + cargoValue > trunkMaxCapacity{
                    print("Такое количество груза не войдет в машину!")
                }
                else {
                    self .trunkCurrentCapasity += cargoValue
                }
            }
            else {
                //Проверяем если количество груза меньше чем количество которое пытаемся разгрузить и выводим ошибку
                if  self .trunkCurrentCapasity < cargoValue {
                    print("В багажнике нет такого количества груза!")
                }
                else {
                    self .trunkCurrentCapasity -= cargoValue
                }
            }
        }
    }
    
    //Функция вывода свойств и состояний автомобиля
    func printCarValues(){
        print("Данные автомобиля:")
        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем багажника: \(trunkMaxCapacity)")
        print("Состояние автомобиля:")
        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Багажник заполнен на: \(trunkCurrentCapasity)")
    }
    
    //Конструктор в зависимости от модели автомобиля
    init (manufacturer : Manufacturer){
        switch manufacturer {
        case .toyota:
            modelYear = 2010
            trunkMaxCapacity = 100
        case .ford:
            modelYear = 2012
            trunkMaxCapacity = 110
        case .honda:
            modelYear = 2014
            trunkMaxCapacity = 80
        }
        self .manufacturer = manufacturer
    }
}

//Создадим переменную автомобиля
var toyotaCar = Car(manufacturer: .toyota)
//Выведем значения свойств автомобиля
toyotaCar.printCarValues()
//Включим двигатель
toyotaCar.changeCarState(action: .engineAction())
//Попытаемся закрыть окна
toyotaCar.changeCarState(action: .windowsAction(open: false))
//Заполним багажник
toyotaCar.changeCarState(action: .cargoAction(cargoValue: 80))
//Выведем текущие состояние авто
toyotaCar.printCarValues()


//-----------------------------------------------------------------------------
//Создадим структуру грузовика
struct Truck {
    //Производитель
    let manufacturer : Manufacturer
    //Год выпуска
    let modelYear : UInt
    //Макимальный объем кузова
    let bodyMaxCapacity : Double
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
    //Текущий объем груза в кузове
    var bodyCurrentCapasity : Double = 0{
        didSet {
            if bodyMaxCapacity == bodyCurrentCapasity{
                print("Кузов полный")
            }
            else if bodyCurrentCapasity == 0{
                print("Кузов пустой")
            }
            else{
                print("Кузов заполнен на \(bodyCurrentCapasity)")
            }
        }
    }
    
    //Функция дествий с грузовиком
    mutating func changeTruckState(action : Actions){
        
        switch action{
            
        case let .engineAction(turnOn) :
            //Проверяем если текущее состояние двигателя соответсвует действию выводим ошибку
            if self .engineOn == turnOn {
                print("Двигатель уже \(self .engineOn ? "запущен" : "заглушен")")
            }
            else{
                self .engineOn = turnOn
            }
        case let .windowsAction(open) :
            //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
            if self .windowsAreOpen == open {
                print("Окна уже \(self .windowsAreOpen ? "опущены" : "подняты")")
            }
            else{
                self .windowsAreOpen = open
            }
        case let .cargoAction(cargoValue, load):
            if load {
                //Проверяем если количество груза привышает максимальный объем выводим ошибку
                if  self .bodyCurrentCapasity + cargoValue > bodyMaxCapacity{
                    print("Такое количество груза не войдет в кузов!")
                }
                else {
                    self .bodyCurrentCapasity += cargoValue
                }
            }
            else {
                //Проверяем если количество груза меньше чем количество которое пытаемся разгрузить и выводим ошибку
                if  self .bodyCurrentCapasity < cargoValue {
                    print("В кузове нет такого количества груза!")
                }
                else {
                    self .bodyCurrentCapasity -= cargoValue
                }
            }
        }
    }
    //Функция вывода свойств и состояний грузовика
    func printTruckValues(){
        print("Данные грузовика:")
        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем кузова: \(bodyMaxCapacity)")
        print("Состояние автомобиля:")
        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Кузов заполнен на: \(bodyCurrentCapasity)")
    }
    //Конструктор в зависимости от модели автомобиля
    init (manufacturer : Manufacturer){
        switch manufacturer {
        case .toyota:
            modelYear = 2013
            bodyMaxCapacity = 1100
        case .ford:
            modelYear = 2000
            bodyMaxCapacity = 2000
        case .honda:
            modelYear = 2011
            bodyMaxCapacity = 3500
        }
        self .manufacturer = manufacturer
    }

}

//Создадим переменную грузовика
var hondaTruck = Truck(manufacturer: .honda)
//Выведем значения свойств автомобиля
hondaTruck.printTruckValues()
//Запустим двигатель
hondaTruck.changeTruckState(action: .engineAction())
//Опустим окна
hondaTruck.changeTruckState(action: .windowsAction())
//Загрузим и разгрузим груз
hondaTruck.changeTruckState(action: .cargoAction(cargoValue: 500))
hondaTruck.changeTruckState(action: .cargoAction(cargoValue: 3000))
hondaTruck.changeTruckState(action: .cargoAction(cargoValue: 2300, load: false))
