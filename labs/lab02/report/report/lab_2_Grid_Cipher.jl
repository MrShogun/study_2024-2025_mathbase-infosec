include("lab_2_Route_Cipher.jl")

# Функция для заполнения сетки с использованием решетки (шаблона) и текста
function Fill_Grid_With_Grille(Message::String, Grille::Matrix{Bool})::Matrix{String}
    Mat_size = size(Grille)[1]
    Grid = ["" for _ in 1:Mat_size, _ in 1:Mat_size]
    Text_Indices = collect(enumerate(Message))
    index = 1
    # Вращения 4 раза по 90 градусов
    for rotation in 1:4
        for i in 1:Mat_size
            for j in 1:Mat_size
                # Если в решете есть прорезь
                if Grille[i, j]
                    if index <= length(Message)
                        Grid[i, j] = string(Text_Indices[index][2])
                        index += 1
                    else # Заполнение оставшегося пр-ва таблицы
                        Grid[i, j] = string('а')
                    end
                end
            end
        end
        Grille = rotr90(Grille)
    end
    return Grid
end

function Grid_Cipher(Message::String, Grille::Matrix{Bool}, key::String)::String
    Mat_size = length(key)  # Ключ - размерность матрицы
    Grid = Fill_Grid_With_Grille(Message, Grille)
    Encrypted_Message = ""
    Cols_Indices = Find_Alphabetical_Indices(key)
    for j in Cols_Indices # Столбцы
        for i in 1:Mat_size  # Строки
            # Читаем по столбцам в 
            # алфавитном порядке индексов ключа
            Encrypted_Message *= Grid[i, j]
        end
    end
    return Encrypted_Message
end

function Grid_Decipher(Encrypted_Message::String, Grille::Matrix{Bool}, key::String)::String
    Mat_size = length(key)  # Ключ - размерность матрицы
    # Записываем шифр в таблицу по строкам
    Grid = Fill_Table(Encrypted_Message, Mat_size, Mat_size)
    Initial_Message = ""
    Rows_Indices = Find_Alphabetical_Indices(key)
    Temp_Grid = ["" for _ in 1:Mat_size, _ in 1:Mat_size]
    # Преобразуем таблицу с зашифрованным текстом к
    # виду аналогичному записанному с помощью
    # решета исходного сообщения
    for j in 1:Mat_size # Строки
        temp_col = []
        for i in sortperm(Rows_Indices)  # Столбцы
            push!(temp_col, Grid[i, j])
        end
        # Из выбранных из столбца элементов
        # формируем строку
        for k in 1:Mat_size 
            Temp_Grid[j, k] = temp_col[k]
        end 
    end 
    for rotation in 1:4
        for i in 1:Mat_size
            for j in 1:Mat_size
                # Если в решете есть прорезь
                if Grille[i, j]
                    Initial_Message *= Temp_Grid[i, j]
                end
            end
        end
        Grille = rotr90(Grille)
    end
    return Initial_Message
end

# Пример использования
text = "договорподписали"
key = "шифр"
Mat_size = Int64(floor(sqrt(length(text))))
#size = 4  # Размер сетки (должен быть квадратом)
grille = [false for i in 1:Mat_size, j in 1:Mat_size]
indexes = [(1, 4) (3, 2) (3, 4) (4, 3)]
for (i, j) in indexes
    grille[i, j] = true
end
println("\n\nИсходное сообщение: $text")
println("\n\nКлюч шифрования: $key")
println("\nРешето для записи сообщения в таблицу: ")
for i in 1:Mat_size
    for j in 1:Mat_size
        print(grille[i, j], " ")
    end
    println("\n")
end

println("\nЗаписанное в таблицу сообщение: ")
grid = Fill_Grid_With_Grille(text, grille)
for i in 1:Mat_size
    for j in 1:Mat_size
        print(grid[i, j], " ")
    end
    println("\n")
end

# Шифрование
Encrypted_Message = Grid_Cipher(text, grille, key)
println("Зашифрованный текст (Шифрование с помощью решёток): $Encrypted_Message")

# Расшифрование
Decrypted_Message = Grid_Decipher(Encrypted_Message, grille, key)
println("Расшифрованный текст (Шифрование с помощью решёток): $Decrypted_Message")