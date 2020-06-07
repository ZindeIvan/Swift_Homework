import Foundation

enum Manufacturer : String{
    case toyota = "Toyota"
    case ford   = "Ford"
    case honda  = "Honda"
}

struct Car {
    let manufacturer : Manufacturer
    let modelYear : UInt
    let trunkMaxCapacity : Double
    var engineOn : Bool
    var windowsAreOpen : Bool
    var trunkCurrentCapasity : Double
}

struct Truck {
    let manufacturer : Manufacturer
    let modelYear : UInt
    let bodyMaxCapacity : Double
    var engineOn : Bool
    var windowsAreOpen : Bool
    var bodyCurrentCapasity : Double
}
