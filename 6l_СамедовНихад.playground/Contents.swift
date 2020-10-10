import UIKit

class Queue<T: LosslessStringConvertible> {
    var queue: [T]
    var isEmpty: Bool {
        get {
            return queue.count == 0
        }
    }
    
    func filter(predicate: (T) -> Bool ) -> [T] {
        var tmpArray = [T]()
        for element in queue {
            if predicate(element) {
                tmpArray.append(element)
            }
        }
        return tmpArray
    }
    
    init() {
        queue = [T]()
    }
    
    init(initialElements: [T]) {
        queue = initialElements
    }
    
    func enQueue(el: T) {
        queue.append(el)
    }
    
    func deQueue() {
        guard queue.count > 0 else {
            print("Queue has no elements to deque")
            return
        }
        queue.removeFirst()
    }
    
    func all() -> [T] {
        return queue
    }
    
    subscript(index: Int) -> T? {
        get {
            guard index >= 0 && index < queue.count else { return nil }
            return queue[index]
        }
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return "[" + (queue.map{ String($0)}).joined(separator: ", ") + "]"
    }
}

var que = Queue<Int>()

que.enQueue(el: 1)
que.enQueue(el: 2)
que.enQueue(el: 3)
que.enQueue(el: 4)
print(que.filter{ $0 % 2 == 0 })
print(que.filter{ $0 % 2 != 0 })
que.deQueue()
que.deQueue()
print(que)
print(que.all())
print(que[1]!)
print(que[2])
