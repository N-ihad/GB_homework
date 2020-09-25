import Foundation

// MARK: - First Task
func isNumberEven(_ number: Int) -> Bool {
    return number % 2 == 0
}
isNumberEven(10)


// MARK: - Second Task
func isNumberFractionOf3(_ number: Int) -> Bool {
    return number % 3 == 0
}
isNumberFractionOf3(9)


// MARK: - Third Task
var ascendingArr = Array(1...100)


// MARK: - Fourth Task
ascendingArr.removeAll(where: { isNumberEven($0) || !(isNumberFractionOf3($0)) })
ascendingArr


// MARK: - Fifth Task
func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

func fib(_ n: Int) -> [NSDecimalNumber] {
    guard n > 1 else { return [NSDecimalNumber(value: n)] }
    var fibSeq: [NSDecimalNumber] = [0, 1]
    for i in 2...n {
        fibSeq.append(fibSeq[i-2] + fibSeq[i-1])
    }
    return fibSeq
}

fib(100)


// MARK: - Sixth Task
func genPrimeNumbers(n: Int) -> [Int] {
    let seq = Array(2...n)
    var primeNumbers = [Int]()
    let isBasePrimeNumber = { return $0 == 2 || $0 == 3 || $0 == 5 || $0 == 7}
    let isFractionOfBasePrimeNumbers = { return $0 % 2 == 0 || $0 % 3 == 0 || $0 % 5 == 0 || $0 % 7 == 0}
    
    for el in seq {
        if isBasePrimeNumber(el) { primeNumbers.append(el); continue }
        if isFractionOfBasePrimeNumbers(el) { continue }
        primeNumbers.append(el)
    }
    return primeNumbers
}

genPrimeNumbers(n: 100)
