using LinearAlgebra

function f_c(a::Int, b::Int, c::Int, p::Int)
    if c < div(p, 2)
        return (a * c) % p, [1, 0]
    else
        return (b * c) % p, [0, 1]
    end
end

function Find_Order(n::Int, p::Int)
    if n % p == 1
        return 1
    end
    t = n % p
    for i in 2:p
        if (t * n) % p == 1
            return i
        end
        t = (t * n) % p 
    end
    return nothing
end

function Power_Mod(a::Int, b::Int, p::Int)::Int
    res = 1
    a = a % p
    while b > 0
        if b % 2 == 1
            res = (res * a) % p
        end
        b = div(b, 2)
        a = (a * a) % p
    end
    return res
end

function Pollard_Rho_Method(p::Int, a::Int, b::Int, u = 2, v = 2)
    c = (a^u * b^v) % p
    c_log = [u, v]
    d = c
    d_log = [u, v]

    i = 0
    while true
        println("Шаг: $i, \t c: $(c % p), c_log: $(c_log[2])x + $(c_log[1]), \t d: $(d % p), d_log: $(d_log[2])x + $(d_log[1])")
        i += 1
        # Обновим значения для c
        c, c_log_n = f_c(a, b, c, p)
        c_log += c_log_n
        # Обновим значения для d (двойной шаг)
        d, d_log_n = f_c(a, b, d, p)
        d_log += d_log_n
        d, d_log_n = f_c(a, b, d, p)
        d_log += d_log_n

        # Проверяем совпадение c и d
        if (c - d) % p == 0
            println("Шаг: $i, \t c: $(c % p), c_log: $(c_log[2])x + $(c_log[1]), \t d: $(d % p), d_log: $(d_log[2])x + $(d_log[1])")
            order = Find_Order(a, p)
            if order === nothing
                return "Порядок числа a = $a (по модулю p = $p) не найден"
            end

            cd_log = c_log - d_log
            r = (order - abs(cd_log[1]))
            for i in 0:(order - 1)
                if (r + i * order) % cd_log[2] == 0
                    return abs(div(r + i * order, cd_log[2]))
                end
            end
        end
    end
end

# Исходные данные a^b = x (mod p)
a1 = 10 # Основание логарифма
b1 = 64 # Число, для которого ищем логарифм
p1 = 107 # Модуль конечного поля
println("Начальные данные: a = $a1, b = $b1, p = $p1, r = $(Find_Order(a1, p1))")

# Вызов функции p-метода Полларда для дискретного логарифмирования
x1 = Pollard_Rho_Method(p1, a1, b1)

println("Дискретный логарифм 10^64 = x (mod 107) равняется: x = $x1")

# Проверка результата
if Power_Mod(a1, x1, p1) == b1
    println("Дискретный логарифм: x = $x1")
else
    println("Решение не найдено")
end
println("\n")


# Исходные данные a^b = x (mod p)
a2 = 2 # Основание логарифма
b2 = 22 # Число, для которого ищем логарифм
p2 = 29 # Модуль конечного поля
println("Начальные данные: a = $a2, b = $b2, p = $p2, r = $(Find_Order(a2, p2))")

# Вызов функции p-метода Полларда для дискретного логарифмирования
x2 = Pollard_Rho_Method(p2, a2, b2)

println("Дискретный логарифм 2^22 = x (mod 29) равняется: x = $x2")

# Проверка результата
if Power_Mod(a2, x2, p2) == b2
    println("Дискретный логарифм: x = $x2")
else
    println("Решение не найдено")
end