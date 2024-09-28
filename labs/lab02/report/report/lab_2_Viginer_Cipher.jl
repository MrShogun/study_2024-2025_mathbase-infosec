alphabet = 'а':'я'
# Функция нахождения массива порядковых
# номеров букв в слове из алфавита
function Word_Alphabet_Serial_Numbers(Word::String)
    Temp_Char_Indices = []
    for char in lowercase(Word)   
        if char in alphabet
            position = findfirst(x -> x == char, alphabet)  
            push!(Temp_Char_Indices, position)
        end  
    end  
    return Temp_Char_Indices
end
# Функция для создания таблицы Виженера
function Create_Vigener_Table()::Matrix{String}
    Tab_size = length(alphabet)
    Vigenere_Table = ["" for _ in 1:Tab_size, _ in 1:Tab_size]
    for i in 1:Tab_size
        for j in 1:Tab_size
            Vigenere_Table[i, j] = string(alphabet[mod(i + j - 2, Tab_size) + 1])
        end
    end
    return Vigenere_Table
end

# Функция шифрования с использованием таблицы Виженера
function Vigener_Cipher(Message::String, key::String)::String
    Message = lowercase(Message)
    key = lowercase(key)
    Vigenere_Table = Create_Vigener_Table()
    Tab_size = length(alphabet)
    # Алфавитные индексы исходного сообщения
    Message_Indices = Word_Alphabet_Serial_Numbers(Message)
    # Алфавитные индексы ключа
    Key_Indices = Word_Alphabet_Serial_Numbers(key)
    Encrypted_Message = ""
    key_length = length(key)
    for (i, j) in enumerate(Message_Indices) # В 1-ой строке
        Encrypted_Message *= Vigenere_Table[Key_Indices[i % key_length == 0 ? key_length : mod(i, key_length)], j]
    end
    return Encrypted_Message
end

# Функция расшифрования с использованием таблицы Виженера
function Vigener_Decipher(Encrypted_Message::String, key::String)::String
    Encrypted_Message = lowercase(Encrypted_Message)
    key = lowercase(key)
    Vigenere_Table = Create_Vigener_Table()
    Tab_size = length(alphabet)
    # Алфавитные индексы зашифрованного сообщения
    Message_Indices = Word_Alphabet_Serial_Numbers(Encrypted_Message)
    # Алфавитные индексы ключа
    Key_Indices = Word_Alphabet_Serial_Numbers(key)
    Initial_Message = ""
    key_length = length(key)
    # Первый способ
    #=for (i, j) in enumerate(Message_Indices) # В первом столбце
        # i - номер "номера", j - номер строки, так как зашифрованную строку
        # расположили как левый крайний столбец, тогда
        # надо сместиться влево на (размер алфавита - (порядковый номер ключа - 1) + 1)
        # так как число скачков на 1 меньше порядкового номера ключа,
        # где первый уводит на последний столбец, поэтому + 1 
        Key_Real_Index = Key_Indices[i % key_length == 0 ? key_length : mod(i, key_length)]
        Left_Col_Shift = Tab_size - Key_Indices[i % key_length == 0 ? key_length : mod(i, key_length)] + 2
        Initial_Message *= Vigenere_Table[j, Key_Real_Index == 1 ?  Key_Real_Index : mod(Left_Col_Shift, Tab_size)]
    end =#
    # Второй способ
    for (i, j) in enumerate(Message_Indices) # В последнем столбце
        # Алфавит в правом крайнем столбце смещён на единицу вниз,
        # Поэтому если номер зашифрованной буквы 32, то она 
        # находится в правом верхнем углу, а относительно столбца
        # происходит (размер алфавита - (порядковый номер ключа - 1))
        # скачков влево
        Key_Real_Index = Key_Indices[i % key_length == 0 ? key_length : mod(i, key_length)]
        Left_Col_Shift = Tab_size - Key_Real_Index + 1
        Initial_Message *= Vigenere_Table[j % Tab_size == 0 ? 1 : j + 1, Left_Col_Shift]
    end 
    return Initial_Message
end

# Пример использования
text = "криптографиясерьезнаянаука"
key = "математика"
println("\n\nИсходное сообщение: $text")
println("Ключ шифрования: $key")

# Шифрование
Encrypted_Message = Vigener_Cipher(text, key)
println("Зашифрованный текст (Шифрование с помощью таблицы Вижинёра): $Encrypted_Message")

# Расшифрование
Decrypted_Message = Vigener_Decipher(Encrypted_Message, key)
println("Расшифрованный текст (Шифрование с помощью таблицы Вижинёра): $Decrypted_Message")