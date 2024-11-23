using Random

"""rho-Метод Полларда"""
function Pollard_rho(n::Int, f = x -> x^2 + 1)::Int
    # Начальное значение
    c = rand(1:n-1)
    a = c
    b = c
    # НОД, начальное значение 1
    d = 1
    while d == 1
        # Генерация последовательности
        a = f(a) % n
        b = f(f(b) % n) % n
        # НОД как разница между a и b
        d = gcd(abs(a - b), n)
    end
    if d == n
        return 1 # Делитель не найден
    else
        return d
    end
end

"""Метод квадратов (Теорема Ферма о разложении)"""
function Fermat_Factorization(n::Int)::Tuple{Int, Int}
    # Начальное значение как округлённый корень исходного числа
    s = ceil(Int, sqrt(n))
    # Из соотношение n = s^2 - t^2
    t2 = s^2 - n
    # Пока соотношение не стало точным для целых чисел
    while sqrt(t2) != floor(sqrt(t2))
        s += 1 # Увеличиваем s
        t2 = x^2 - n
    end
    # Вычисляем t
    t = sqrt(t2)
    return (s - t, s + t)
end

# Пример работы алгоритмов
n_pollard = 1359331  # Число из лабораторной работы для метода Полларда
n_fermat = 15  # Число из лабораторной работы для метода квадратов

println("p-Метод Полларда для числа ", n_pollard)
pollard_factor = Pollard_rho(n_pollard)
println("Нетривиальный делитель: ", pollard_factor)

println("\nМетод квадратов (Теорема Ферма) для числа ", n_fermat)
fermat_factors = Fermat_Factorization(n_fermat)
println("Нетривиальные делители: ", fermat_factors)

println("\nМетод квадратов (Теорема Ферма) для числа ", n_pollard)
fermat_factors = Fermat_Factorization(n_pollard)
println("Нетривиальные делители: ", fermat_factors)