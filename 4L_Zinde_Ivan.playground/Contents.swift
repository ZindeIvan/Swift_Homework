import Foundation

// Создадим перечисление марок автомобилей/грузовиков
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
    
    case trunkAction (liftUp : Bool = true)
    case turboAction (turnOn : Bool = true)
    
}

// Создадим класс Автомобиль
class Car {
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
    func executeCarAction(action : Actions){

        switch action{

        case let .engineAction(turnOn) :
            //Проверяем если текущее состояние двигателя соответсвует действию выводим ошибку
            guard self .engineOn != turnOn  else { print("Двигатель уже \(self .engineOn ? "запущен" : "заглушен")"); return }

            self .engineOn = turnOn

        case let .windowsAction(open) :
            //Проверяем если текущее состояние окон соответсвует действию выводим ошибку
            guard self .windowsAreOpen != open else { print("Окна уже \(self .windowsAreOpen ? "опущены" : "подняты")"); return}

            self .windowsAreOpen = open

        case let .cargoAction(cargoValue, load):
            if load {
                //Проверяем если количество груза привышает максимальный объем выводим ошибку
                guard self .trunkCurrentCapasity + cargoValue <= trunkMaxCapacity else { ("Такое количество груза не войдет в машину!"); return }

                self .trunkCurrentCapasity += cargoValue
            }
            else {
                //Проверяем если количество груза меньше чем количество которое пытаемся разгрузить и выводим ошибку
                guard self .trunkCurrentCapasity > cargoValue  else { print("В багажнике нет такого количества груза!"); return}

                self .trunkCurrentCapasity -= cargoValue

            }
        default :
           return
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

class TrunkCar : Car {
    
    let wheelsCount : Int
    
    var trunkLiftedUp : Bool = false{
        didSet {
            print("Кузов \(oldValue ? "опущен" : "поднят")")
        }
    }
    
    override func executeCarAction(action: Actions) {
        
        super .executeCarAction(action: action)
        
        switch action{

        case let .trunkAction(liftUp) :
           
            guard self .trunkLiftedUp != liftUp  else { print("Кузов уже \(self .trunkLiftedUp ? "поднят" : "опущен")"); return }

            self .trunkLiftedUp = liftUp

        default :
           return
        }
    }
    
    override init (manufacturer : Manufacturer){
        switch manufacturer {
        case .toyota:
            wheelsCount = 6
        case .ford:
            wheelsCount = 4
        case .honda:
           wheelsCount  = 6
        }
        super .init(manufacturer: manufacturer)
    }
    
    override func printCarValues() {
        
        print("Данные грузового автомобиля:")
        print("     Производитель: \(manufacturer.rawValue); Год выпуска: \(modelYear); Максимальный объем кузова: \(trunkMaxCapacity); Количество колес: \(wheelsCount)")
        print("Состояние автомобиля:")
        print("     Двигатель \(engineOn ? "запущен" : "заглушен"); Окна \(windowsAreOpen ? "открыты" : "закрыты"); Кузов заполнен на: \(trunkCurrentCapasity); Кузов \(trunkLiftedUp ? "поднят" : "опущен")")
        
    }
}

var truck = TrunkCar(manufacturer: .ford)
truck.printCarValues()
truck.executeCarAction(action: .trunkAction())
truck.executeCarAction(action: .windowsAction())
truck.executeCarAction(action: .cargoAction(cargoValue: 1000, load: true))
print("1")



