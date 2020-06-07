import Foundation
//Функция опредиления четного числа
func isEven(number: Int) -> Bool {
   return number % 2 == 0
}

//Функция опредиления делится ли число без остатка на 3
func isDevideByThree(number: Int) -> Bool {
    return number % 3 == 0
}

//Зададим переменную массива чисел
var numbersArray : [Int] = []
//Зададим константу первого числа в массиве
let firstPosition : Int = 1
//Зададим константу последнего числа в массиве
let lastPosition : Int = 100

// Заполним массив числами
for index in (firstPosition...lastPosition){
    numbersArray.append(index)
}

//Выведем полученный результат
print("Задание 3. Возрастающий массив чисел:")
print(numbersArray)

print()

//Удалим из массива все четные числа и те что делятся на 3 без остатка
for index in stride(from: numbersArray.count - 1, to: 0, by: -1) {
    if isEven(number: numbersArray[index]){
        numbersArray.remove(at: index)
        continue
    }
    if !(isDevideByThree(number: numbersArray[index])){
        numbersArray.remove(at: index)
    }
}
//Выведем полученный результат
print("Задание 4. Удалить все четные числа и те которые не делятся на 3 без остатка:")
print(numbersArray)

print()

//Функция опредиляет n-ое число в последовательности Фибоначчи
func fibonacci(numberPosition: Int) -> Double {

//Вариант рекурсивного нахождения - но не подходит к условию задачи - так как нам нужно 100 чисел в последовательности
//возможно не до конца верно подобрал алгоритм, но после 80го числа моя машина не справляется =(
//    if numberPosition == 0 {
//        return 0
//    }
//    if numberPosition == 1 {
//        return 1
//    }
//
//    return fibonacci(numberPosition: numberPosition - 1) + fibonacci(numberPosition: numberPosition - 2)
    
//Вариант реализации через цикл - пришлось использовать  Double  так как  в Int не влезло 100е число по количеству чисел
    //Зададим первое число по умолчанию 1
    var firsFibonacciNumber : Double = 1
    //Зададим второе число по умолчанию 1
    var secondFibonacciNumber : Double = 1
    //Укажем индекс обхода
    var index : Int = numberPosition - 2;
    
    //Запустим цикл обхода пока индекс больше 0
    while index > 0 {
        //Зададим переменную суммы 1го и 2го числа(2х предыдущих в последовательности)
        let summ : Double = firsFibonacciNumber + secondFibonacciNumber
        //Присвоим 1му числу значение 2го
        firsFibonacciNumber = secondFibonacciNumber
        //Присвоим 2му числу значение суммы двух предыдущих чисел
        secondFibonacciNumber = summ
        //Уменьшим индекс на 1
        index -= 1
    }
    //Возвращаем результат
    return secondFibonacciNumber
}

//Зададим переменную массива чисел Фибоначии
var fibonacciArray : [Double] = []
//Зададим константу первого числа в массиве чисел Фибоначчи
let fibonacciFirstPosition : Int = 1
//Зададим константу последнего числа в массиве чисел Фибоначчи
let fibonacciLastPosition : Int = 100

//Заполним массив чисел Фибоначчи
for index in (fibonacciFirstPosition...fibonacciLastPosition){
    fibonacciArray.append(fibonacci(numberPosition: index))
}

//Выведем полученный результат
print("Задание 5. Массив из 100 чисел Фибоначчи:")
for index in (0...fibonacciArray.count-1){
    print(String(format: "%.0f",fibonacciArray[index]), terminator:" ")
}

print()
print()

//Функция создания массива простых чисел указанной длины
func createSimpleArray(sizeOfArray :Int) -> [Int]{
    //Зададим переменную массива результата
    var simpleArray : [Int] = []
    //Проверим если длинна отрицательное число - вернем пустой массив
    if sizeOfArray < 0 {
        return simpleArray
    }
    //Зададим переменную чисел/"кандидатов" для подстановки в массив простых чисел
    //Начинаем с 2йки как с первого простого числа
    var itterationNumber : Int = 2;
    //Выполняем цикл пока длина массива не станет равна заданной
    while simpleArray.count < sizeOfArray {
        //Добавляем безусловно число/"кандидат" в массив
        simpleArray.append(itterationNumber)
        //Запускаем цикл по массиву
        for element in simpleArray {
            //Проверяем если добавленный элемент делится без остатка на текущий элемент обхода массива
            //но при этом исклюяаем сам текущий элемент обхода чтобы не удалить его если оно простое
            if simpleArray[simpleArray.count-1] % element == 0 && !(simpleArray[simpleArray.count-1] / element == 1){
                //Удаляем элемент массива если он подходит к условию
                simpleArray.remove(at: simpleArray.count-1)
                break
            }
        }
        //Увеличиваем число/"кандидат"
        itterationNumber += 1
    }
    //Возвращаем итоговый массив
    return simpleArray
}
 
//Выведем результат
print("Задание 6. Массив из 100 простых чисел:")
print(createSimpleArray(sizeOfArray: 100))
