"""Алгоритм 1. Сложение неотрицательных целых чисел"""
function Add_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    # u, v - складываемые числа, записаны в виде массивов цифр, b - основание системы счисления
    n = length(u)
    m = length(v)
    w = zeros(Int, n)
    k = 0
    j = n
    while j > 0
        temp = u[j] + v[j] + k
        w[j] = mod(temp, b)
        k = div(temp, b)
        j -= 1
    end
    w[1] += k
    return w
end

"""Алгоритм 2. Вычитание неотрицательных целых чисел"""
function Subtract_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    # u, v - вычитаемые числа, записаны в виде массивов цифр, b - основание системы счисления
    n = length(u)
    w = zeros(Int, n)
    k = 0
    j = n
    while j > 0
        temp = u[j] - v[j] + k
        w[j] = mod(temp, b)
        k = div(temp, b)
        j -= 1
    end
    w[1] += k
    return w
end

"""Алгоритм 3. Умножение неотрицательных целых чисел столбиком"""
function Multiply_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n = length(u)
    m = length(v)
    w = zeros(Int, n + m)
    j = m
    while j > 0
        if v[j] == 0
            w[j] = 0
            j -= 1
        else
            i = n
            k = 0
            while i > 0
                temp = w[i+j] + u[i] * v[j] + k
                w[i+j] = mod(temp, b)
                k = div(temp, b)
                i -= 1
            end
            w[j] = k
            j -= 1
        end
    end
    return w
end

function Fast_Multiply_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)::Vector{Int}
    n = length(u)
    m = length(v)
    w = zeros(Int, n + m)  # Результат будет длиной n + m
    t = 0  # Переменная для переноса

    for s in 1:(n + m)  # Итерации по разрядам результата
        for i in max(1, s - m + 1):min(n, s) 
            t += u[n - i + 1] * v[m - (s - i)] 
        end
        w[n + m - s + 1] = mod(t, b)  # Записываем младший разряд
        t = div(t, b)  # Переносим в старший разряд
    end

    w[1] += t  # Добавляем оставшийся перенос, если он есть
    return w
end


#="""Алгоритм 5. Деление многоразрядных целых чисел"""
function Divide_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)
    n = length(u)
    t = length(v)
    q = zeros(Int, n - t + 1)
    u0, v0 = 0, 0
    # Запись числа u
    for i in 1:n
        u0 += u[i] * b^(n-i)
    end
    # Запись числа v
    for j in 1:t
        v0 += v[j] * b^(t-j)
    end
    # Выделяем целую часть
    while u0 >= v0 * b^(n - t)
        q[n-t+1] += 1
        u0 -= v0 * b^(n-t)
    end
    # Выделяем цифры остатка
    for i in 1:n
        u[n-i+1] = mod(u0, b)
        u0 = div(u0, b)
    end
    i = n
    while i > t
        if u[i] >= v[t]
            q[i-t] = b - 1
        else
            q[i-t] = div(u[i]*b + u[i], v[t])
        end
        while q[i-t] * (v[t]*b + v[t-1]) > u[i]*b^2 + u[i-1]*b + u[i-2]
            q[i-t] -= 1
        end
        u[i-t] -= q[i-t] * b^(i-t-1) * v[i-t]
        if u[i-t] < 0
            u[i-t] += v[i-t] * b^(i-t-1)
            q[i-t] -= 1
        end
        i -= 1
    end
    r = u 
    return q, r
end =#

#=function Divide_Large_Positive_Numbers(u::Vector{Int}, v::Vector{Int}, b::Int)
    n = length(u)
    t = length(v)
    q = zeros(Int, n - t + 1)
    u0, v0 = 0, 0
    # Запись числа u
    for i in 1:n
        u0 += u[i] * b^(n-i)
    end
    # Запись числа v
    for j in 1:t
        v0 += v[j] * b^(t-j)
    end
    # Выделяем целую часть
    while u0 >= v0 * b^(n - t)
        q[n-t+1] += 1
        u0 -= v0 * b^(n-t)
    end
    # Выделяем цифры остатка
    u = reverse(digits(u0, base = b))
    #n = length(u)
    i = n
    # Основной цикл деления
    while i > t
        u = reverse(digits(u0, base = b))
        println("u = ", u, "\t v = ", v)
        if u[i] >= v[t]
            q[i - t] = b - 1
        else
            q[i - t] = div(u[i] * b + u[i - 1], v[t])
        end

        while q[i - t] * (v[t] * b + v[t-1]) > u[i] * b^2 + u[i - 1] * b + u[i - 2]
            q[i - t] -= 1
        end
        println(q)
        # Вычитаем произведение q[i-t] на сдвинутое v
        u0 -= q[i - t] * b^(i - t - 1) * v0
        println(u0)
        # Корректируем остаток, если он стал отрицательным
        if u0 < 0
            u0 += v0 * b^(i - t - 1)
            q[i - t] -= 1
        end
        i -= 1
    end
    r = reverse(digits(u0, base = b))
    return q, r
    
end =#

#=function div_large_numbers(u::Int, v::Int, b::Int)
    # Преобразуем числа в массивы цифр
    u_digits = reverse(digits(u, base=b))
    v_digits = reverse(digits(v, base=b))

    n = length(u_digits) - 1
    t = length(v_digits) - 1
    q = zeros(Int, n - t + 1)
    r = u

    # Первая часть: деление на старший разряд
    while r >= v * b^(n - t)
        q[n - t + 1] += 1
        r -= v * b^(n - t)
    end

    # Обновляем длину r и пересчитываем
    r_digits = reverse(digits(r, base=b))
    n = length(r_digits) - 1
    t = length(v_digits) - 1

    # Основной цикл деления
    for i in n:-1:(t + 1)
        u_rev = reverse(digits(r, base=b))
        if u_rev[i] >= v_digits[t]
            q[i - t] = b - 1
        else
            q[i - t] = div(u_rev[i] * b + u_rev[i - 1], v_digits[t])
        end

        while q[i - t] * (v_digits[t] * b + v_digits[t-1]) > 
              (u_rev[i] * b^2 + u_rev[i - 1] * b + u_rev[i - 2])
            q[i - t] -= 1
        end

        # Вычитаем произведение q[i-t] на сдвинутое v
        r -= q[i - t] * b^(i - t - 1) * v

        # Корректируем остаток, если он стал отрицательным
        if r < 0
            r += v * b^(i - t - 1)
            q[i - t] -= 1
        end
    end

    return q, r
end =#

function Divide_Large_Positive_Numbers(u::Int, v::Int, b::Int)
    # Преобразуем числа в массивы цифр
    u_digits = reverse(digits(u, base=b))
    v_digits = reverse(digits(v, base=b))

    # Инициализация переменных
    n = length(u_digits)
    t = length(v_digits)
    q = zeros(Int, max(0, n - t + 1)) # Вычисление размера массива q
    r = 0

    # Основной цикл деления
    for i in 1:n
        # Обновляем остаток, добавляя очередную цифру u_digits
        r = r * b + u_digits[i]

        # Определяем текущую цифру частного
        if r >= v
            if i - t + 1 > 0
                q[i - t + 1] = div(r, v)
            else 
                q[i - t + 1] = 0 # Избегаем отрицательных индексов
            end
            r %= v
        else
            if i - t + 1 > 0
                q[i - t + 1] = 0
            end
        end
    end

    # Убираем лишние нули из массива q
    q = q[q .!= 0]

    return q, r
end



# Пример использования 1
b = 10  # Основание системы счисления

# Пример чисел для тестирования
u = [6, 9, 5, 7]  # Число u = 6957
v = [1, 4, 2, 3]  # Число v = 1423
u1, v1 = 6957, 1423

println("Число u: ", u, "\t Число v:", v)

# Алгоритм 1: Сложение
sum_result = Add_Large_Positive_Numbers(u, v, b)
println("Сумма: ", sum_result)

# Алгоритм 2: Вычитание
subtract_result = Subtract_Large_Positive_Numbers(u, v, b)
println("Разность: ", subtract_result)

# Алгоритм 3: Умножение
multiply_result = Multiply_Large_Positive_Numbers(u, v, b)
println("Произведение: ", multiply_result)

# Алгоритм 4: Быстрое умножение
fast_multiply_result = Fast_Multiply_Large_Positive_Numbers(u, v, b)
println("Быстрый столбик: ", fast_multiply_result)

# Алгоритм 5: Деление
quotient, remainder = Divide_Large_Positive_Numbers(u1, v1, b)
println("Частное: ", quotient)
println("Остаток: ", remainder)



# Пример использования 2
b = 10  # Основание системы счисления

# Пример чисел для тестирования
u = [6, 9, 5, 7, 1, 4, 2]  # Число u = 6957142
v = [1, 4, 2, 3]  # Число v = 1423

println("\nЧисло u: ", u, "\t Число v:", v)

# Алгоритм 3: Умножение
multiply_result = Multiply_Large_Positive_Numbers(u, v, b)
println("Произведение: ", multiply_result)

# Алгоритм 4: Быстрое умножение
fast_multiply_result = Fast_Multiply_Large_Positive_Numbers(u, v, b)
println("Быстрый столбик: ", fast_multiply_result)

# Алгоритм 5: Деление
u2, v2 = 6957142, 1423
#quotient, remainder = Divide_Large_Positive_Numbers(u, v, b)
quotient, remainder = Divide_Large_Positive_Numbers(u2, v2, b)
println("Частное: ", quotient)
println("Остаток: ", remainder)