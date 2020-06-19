import Foundation

//Структуру Очередь
struct Queue<T : Comparable> :CustomStringConvertible {
    //Свойство типа массив которое будет хранить элементы очереди
    private var elements: [T] = []
    
    //Поддержка протокола CustomStringConvertible
    var description: String {
        return "\(elements)"
    }
    
    //Метод добавление элементов в очередь
    mutating func enqueue(_ element: T){
        elements.append(element)
    }
    
    //Метод удаления элемента из очереди по принципу FIFO
    mutating func dequeue() -> T? {
        guard elements.count > 0 else {return nil}
        return elements.removeFirst()
    }
    
    //Метод получения первого(переднего) элемента очереди
    func front() -> T? {
        return elements.first
    }
    
    //Метод получения последнего(заднего) элемента очереди
    func back() -> T? {
        return elements.last
    }
    
    //Метод сортировки высшего порядка
    mutating func sort(predicate : (T, T) -> Bool ){
        //Начальная позиция обхода очереди
        var startPosition = 0
        //Запускаем цикл по элементам начиная с начальной позиции
        while startPosition < elements.count {
            //Обходим циклом все последующие элементы до конца очереди
            for index in startPosition+1..<elements.count {
                //Если замыкание по двум сравниваемым элементам возвращает Ложь - меняем элементы местами
                if !predicate(elements[startPosition], elements[index]){
                    elements.swapAt(startPosition, index)
                }
            }
            //Увеличиваем начальную позицию
            startPosition += 1
        }
    }
    
    //Метод "обрезки" очереди
    mutating func trim(predicate : (T) -> Bool){
        //Запускаем цикл с конца очереди
        for index in stride(from: elements.count - 1, through: 0, by: -1) {
            //Если замыкание для элемента вернет Ложь - удаляем элемент из очереди
            if !predicate(elements[index]) {
                elements.remove(at: index)
            }
        }
    }
    
    //Метод фильтр элементов очереди - возвращает новую очередь с отбором из замыкания
    func filter(predicate : (T) -> Bool) -> Queue<T>{
        //Временная переменная для хранения результата
        var tempQueue = Queue<T>()
        //Цикл обхода элементов очереди
        for element in elements {
            //Если замыкание для элемента очереди возвращает Истина -
            //добавляем данный элемент в результирующую переменную
            if predicate(element){
                tempQueue.enqueue(element)
            }
        }
        return tempQueue
    }
    
    //Subscript для очереди
    subscript(index: Int) -> T? {
        get {
            guard index < elements.count && index >= 0 else { return nil }
            return elements[index]
        }
        set {
            guard index < elements.count && index >= 0 else { return }
            elements[index] = newValue!
        }
    }
    
}

//Создадим переменную очереди из Int
var newQueue = Queue<Int>()
//Проинициализируем Очередь элементами
newQueue.enqueue(1)
newQueue.enqueue(5)
newQueue.enqueue(2)
newQueue.enqueue(3)
newQueue.enqueue(4)
print (newQueue)
//Выведем первый элемент очереди
print(newQueue.front() ?? "Очередь пуста")
//Выведем последний элемент очереди
print(newQueue.back() ?? "Очередь пуста")
//Отсортируем очередь по убыванию
newQueue.sort{$0 > $1}
print (newQueue)
//Получим новую очередь для всех элементов >= 3
print(newQueue.filter{$0 >= 3})
//Оставим в очереди только четные элементы
newQueue.trim{$0 % 2 == 0}
print (newQueue)
//Проверим работу Subscript
print(newQueue[0] ?? "Нет данных")
print(newQueue[-1] ?? "Нет данных")
print(newQueue[9] ?? "Нет данных")
//"Выпустим" элементы из очереди
print(newQueue.dequeue() ?? "Очередь пуста")
print(newQueue)
print(newQueue.dequeue() ?? "Очередь пуста")
print(newQueue)
print(newQueue.dequeue() ?? "Очередь пуста")
