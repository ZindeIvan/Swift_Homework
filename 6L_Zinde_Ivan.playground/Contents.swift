import Foundation

struct Queue<T> :CustomStringConvertible {
    private var elements: [T] = []
    
    var description: String {
        return "\(elements)"
    }
    
    mutating func enqueue(_ element: T){
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard elements.count > 0 else {return nil}
        return elements.removeFirst()
    }
    
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

var newQueue = Queue<String>()
newQueue.enqueue("First")
newQueue.enqueue("Second")
newQueue.enqueue("Third")
print (newQueue)

print(newQueue.dequeue() ?? "QueueIsEmpty")
print(newQueue)
print(newQueue[9])
print(newQueue.dequeue() ?? "QueueIsEmpty")
print(newQueue.dequeue() ?? "QueueIsEmpty")
print(newQueue.dequeue() ?? "QueueIsEmpty")


