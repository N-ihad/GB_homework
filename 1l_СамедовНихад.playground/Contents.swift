import UIKit

// Первое задание
func solveQuadraticEquation(a: Double, b: Double, c: Double) {
    let discriminant = b*b-4*a*c
    switch discriminant {
    case 1...:
        print("2 решения:")
        print("x1=\((-b+sqrt(discriminant))/(2*a))")
        print("x2=\((-b-sqrt(discriminant))/(2*a))")
    case 0:
        print("1 решение:")
        print("x=\(-b/(2*a))")
    case ..<0:
        print("КомплЕксное решение:")
        print("x1=\(-b/(2*a)) + \(sqrt(-discriminant)/(2*a))i")
        print("x2=\(-b/(2*a)) - \(sqrt(-discriminant)/(2*a))i")
    default:
        print("Что-то пошло не так")
    }
}

// Второе задание
func calcAreaPerimeterAndHypotenuse(cathetus1: Double, cathetus2: Double) {
    if cathetus1<0 || cathetus2<0 {
        print("Стороны треугольника не могут быть отрицательными")
        return
    }
    
    let area = (1/2)*cathetus1*cathetus2
    let hypotenuse = sqrt(cathetus1*cathetus1+cathetus2*cathetus2)
    let perimeter = cathetus1+cathetus2+hypotenuse
    
    print("Площадь прямоугольного треугольника: \(area)")
    print("Периметр прямоугольного треугольника: \(perimeter)")
    print("Гипотенуза прямоугольного треугольника: \(hypotenuse)")
}

// Третье задание
func calcDepositAfter5Years(initialDeposit: Double, annualPercentage: Double) -> Double? {
    if annualPercentage<0 {
        print("Годовой начисляемый процент не может быть отрицательным")
        return nil
    }
    if initialDeposit<0 {
        print("Начальная сумма вклада не может быть отрицательной")
        return nil
    }
    let mltplr = 1+(annualPercentage/100)
    return ((((initialDeposit*mltplr)*mltplr)*mltplr)*mltplr)*mltplr
}


// MARK: Quadratic equation
solveQuadraticEquation(a: 5, b: 6, c: 1)
solveQuadraticEquation(a: 5, b: 2, c: 1)

// MARK: Find area, perimeter and hypotenuse of a right triangle
calcAreaPerimeterAndHypotenuse(cathetus1: 3, cathetus2: 4)

// MARK: Calculate deposit amount of a client after 5 years
if let depositAmount = calcDepositAfter5Years(initialDeposit: 1000, annualPercentage: 10) {
    print("Сумма вклада через 5 лет: \(depositAmount)")
}
