import Foundation

//1)Решить квадратное уравнение Х^2 - 8Х + 7 = 0

//Установим константы коэффициентов уравнения
let coef_A: Double = 1
let coef_B: Double = -8
let coef_C: Double = 7

//Иничиализируем константы решения решения уравнения
let unknown_X_1: Double = (-coef_B + sqrt(coef_B*coef_B - 4*coef_A*coef_C))/2*coef_A
let unknown_X_2: Double = (-coef_B - sqrt(coef_B*coef_B - 4*coef_A*coef_C))/2*coef_A

//Выведем решение
print("Задание 1")
print("Решение квадратного уравнения Х^2 - 8Х + 7 = 0")
print("Решение уравнения:")
print("Х1 = "+String(format: "%.3f",unknown_X_1))
print("Х2 = "+String(format: "%.3f",unknown_X_2))
print()

//2)Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу

//Зададим константы катетов
let cath_A: Double = 5
let cath_B: Double = 7

//Зададим и вычислим константы гипотенузы, площади и периметра
let hyp_C: Double = sqrt(cath_A*cath_A + cath_B*cath_B)
let square_S: Double = cath_A*cath_B/2
let perim_P: Double = cath_A + cath_B + hyp_C

//Выведем результаты
print("Задание 2")
print("Задан прямоугольный треугольник с катетом = "+String(format: "%.2f",cath_A)+" и катетом ="+String(format: "%.2f",cath_B))
print("Гипотенуза = "+String(format: "%.2f",hyp_C)+" Периметр = "+String(format: "%.2f",perim_P)+" Площадь = "+String(format: "%.2f",square_S))
print()

//3)Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет

//Зададим константы суммы депозита и процента
let deposit_Sum:Double = 20000
let deposit_Percent:Double = 10

//Зададим переменную итоговой суммы
var total_Sum:Double = 0

//проведем расчет за 5 лет
total_Sum = deposit_Sum + deposit_Sum * deposit_Percent / 100 //1й год
total_Sum = total_Sum + total_Sum * deposit_Percent / 100     //2й год
total_Sum = total_Sum + total_Sum * deposit_Percent / 100     //3й год
total_Sum = total_Sum + total_Sum * deposit_Percent / 100     //4й год
total_Sum = total_Sum + total_Sum * deposit_Percent / 100     //5й год

//Выведем результат
print("Задание 3")
print("Для дипозита с суммой равной: "+String(format: "%.2f",deposit_Sum)+" под годовой процент равный: "+String(format: "%.2f",deposit_Percent)+" итоговая сумма через 5 лет составит: "+String(format: "%.2f",total_Sum))
