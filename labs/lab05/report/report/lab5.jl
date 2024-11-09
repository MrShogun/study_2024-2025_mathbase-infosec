using Random

"""Возведение в степень по модулю a^b mod c"""
function powermod(a::Int, b::Int, c::Int)::Int
    res = 1
    a = a % c
    while b > 0
        if b % 2 == 1
            res = (res * a) % c
        end
        b = div(b, 2)
        a = (a * a) % c
    end
    return res
end

"""Функция проверки числа на простоту с помощью теста Ферма"""
function Fermat_Test(n::Int, k::Int = 5)::Bool
    if n == 2
        return true
    elseif n < 2 || n % 2 == 0
        return false
    end
    if n < 5
        error("Число должно быть больше 4")
    end
    for _ in 1:k
        # Выбираем случайное число a, 2 <= a <= n-2
        a = rand(2:n-2)
        # Проверяем условие Ферма: a^(n-1) = 1 (mod n)
        if gcd(a, n) != 1 || powermod(a, n-1, n) != 1
            return false # Число составное
        end
    end
    return true # Число, вероятно, простое
end

"""Вычисление числа делений на 2"""
function Powers_of_Two(a::Int)::Int
    k = 0
    while a % 2 == 0
        k += 1
        a = div(a, 2)
    end
    return k
end

"""Вычисление символа Якоби (a/n)"""
function Jacobi_Symbol(a::Int, n::Int)::Int
    if n < 3 || n % 2 == 0
        error("n должно быть положительным нечётным числом большим 2")
    end
    if a >= n || a < 0
        error("a должно быть неотрицательным числом меньшим n")
    end
    if gcd(a, n) != 1 return 0 end
    g = 1
    while a > 1
        k = Powers_of_Two(a)
        s = 1
        if k % 2 == 1
            if n % 8 == 3 || n % 8 == 5
                s = -1
            end
        end
        a = div(a, 2^k)
        if a == 1
            return g*s
        end
        if a % 4 == 3 && n % 4 == 3
            s = -s
        end
        a, n, g = n % a, a, g*s
    end
    if a == 0 return 0 end
    return g
end 

"""Функция проверки числа на простоту с помощью теста Соловэя-Штрассена"""
function Solovay_Strassen_Test(n::Int, k::Int = 5)::Bool
    if n < 2 || n % 2 == 0
        return false
    end
    if n < 5
        error("Число должно быть больше 4")
    end
    for _ in 1:k
        # Выбираем случ число a, 2 <= a < n-2
        a = rand(2:n-3)
        # Неотрицательный остаток
        r = powermod(a, div(n-1, 2), n)
        if r != 1 && r != n - 1
            return false # Число составное
        end
        jacobi = Jacobi_Symbol(a, n)
        if r != mod(jacobi, n)
            return false # Число составное
        end
    end
    return true # Число, вероятно, простое
end

"""Функция проверки числа на простоту с помощью теста Миллера-Рабина"""
function Miller_Rabin_Test(n::Int, k::Int = 5)::Bool
    if n < 2 || n % 2 == 0
        return false
    end
    if n < 5
        error("Число должно быть больше 4")
    end
    # Представляем (n-1) в виде 2^s * r, где число r - нечётное
    s = 0
    r = n - 1
    while r % 2 == 0
        r = div(r, 2)
        s += 1
    end
    for _ in 1:k
        # Выбираем случ число a, 2 <= a < n-2
        a = rand(2:n-3)
        # Вычисляем y = a^r mod n
        y = powermod(a, r, n)
        if y != 1 && y != n - 1
            for _ in 1:(s-1)
                y = powermod(y, 2, n)
                if y == 1
                    return false # Число составное
                end
            end
            if y != n - 1
                return false # Число составное
            end
        end
    end
    return true # Число, вероятно, простое
end

# Тестирование каждого алгоритма на примерах
function Test_Algorithms(n)
    println("Тестирование числа $n на простоту:")
    
    # Тест Ферма
    fermat_result = Fermat_Test(n)
    println("Тест Ферма: $(fermat_result ? "вероятно простое" : "составное")")
    
    # Тест Соловэя-Штрассена
    solovay_result = Solovay_Strassen_Test(n)
    println("Тест Соловэя-Штрассена: $(solovay_result ? "вероятно простое" : "составное")")
    
    # Тест Миллера-Рабина
    miller_rabin_result = Miller_Rabin_Test(n)
    println("Тест Миллера-Рабина: $(miller_rabin_result ? "вероятно простое" : "составное")")
end

# Пример использования: (простое, составное, простое, простое,
# составное, составное, составное, простое, простое)
for n in [13, 15, 17, 19, 561, 1105, 1729, 2143, 2399]
    Test_Algorithms(n)
    println("-----------------------------------")
end