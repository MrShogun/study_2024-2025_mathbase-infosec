alphabet = 'а':'я'
function Find_Alphabetical_Indices(word::String)  
    Temp_Char_Indices = Int[]
    # Находим порядковые (в алфавите) значения символов в слове
    for char in lowercase(word)   
        if char in alphabet
            position = findfirst(x -> x == char, alphabet)  
            push!(Temp_Char_Indices, position)
        end  
    end  
    # Находим индексы символом в алфавитном порядке в слове
    return sortperm(Temp_Char_Indices)
end  

function Fill_Table(Input_Text::String, rows::Int, cols::Int)
    # cols - число столбцов, rows - число строк (длина ключа)
    table = ["" for _ in 1:rows, _ in 1:cols]
    Text_Indices = collect(enumerate(Input_Text))
    index = 1
    for i in 1:rows # Строки
        for j in 1:cols # Столбцы
            if index <= length(Input_Text)
                # Заполнение таблицы символами 
                # сообщения по строкам
                table[i, j] = string(Text_Indices[index][2])
                index += 1
            else # Заполнение оставшегося пр-ва таблицы
                table[i, j] = string('а')
            end
        end
    end
    return table
end 

function Route_Cipher(Message::String, key::String)::String
    # n (cols) - число столбцов, m (rows) - число строк (длина ключа)
    n = length(key)  # Число столбцов
    m = div(length(Message), n) + 1  # Число строк
    table = Fill_Table(Message, m, n)
    Encrypted_Message = ""
    Cols_Indices = Find_Alphabetical_Indices(key)
    for j in Cols_Indices # Столбцы
        for i in 1:m  # Строки
            # Читаем по столбцам в 
            # алфавитном порядке индексов ключа
            Encrypted_Message *= table[i, j]
        end
    end
    return Encrypted_Message
end

function Route_Decipher(Encrypted_Message::String, key::String)::String
    # n (cols) - число столбцов, m (rows) - число строк (длина ключа)
    m = length(key)  # Ключ - число строк
    n = div(length(Encrypted_Message), m)
    # Записываем шифр в таблицу по строкам
    # (исходная была n x m, данная - m x n)
    table = Fill_Table(Encrypted_Message, m, n)
    Initial_Message = ""
    Rows_Indices = Find_Alphabetical_Indices(key)
    for j in 1:n # Строки
        for i in sortperm(Rows_Indices)  # Столбцы
            # Читаем по столбцам, выбирая
            # элементы в соответствии с изначальным
            # расположением столбцов
            Initial_Message *= table[i, j]
        end
    end
    return Initial_Message
end
# Пример использования
Message = "нельзянедооцениватьпротивника"
key = "пароль"
println("Исходное сообщение: $Message")
# Шифрование
Encrypted_Message = Route_Cipher(Message, key)
println("Зашифрованный текст (Маршрутное шифрование): $Encrypted_Message")
# Расшифрование
Initial_Message = Route_Decipher(Encrypted_Message, key)
println("Расшифрованный текст (Маршрутное шифрование): $Initial_Message")