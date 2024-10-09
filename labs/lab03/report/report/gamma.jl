# Функция для преобразования строки в числовое представление на основе алфавитного порядка
alphabet = 'а':'я'
function Text_to_Numbers(Text::String, Alphabet::StepRange{Char, Int64} = alphabet)::Vector{Any}
    numbers = []
    for char in lowercase(Text)
        push!(numbers, findfirst(c -> c == char, Alphabet))
    end
    return numbers
end

# Функция для преобразования числового представления обратно в строку
function Numbers_to_Text(Numbers::Vector{Any}, Alphabet::StepRange{Char, Int64} = alphabet)::String
    text = ""
    for number in Numbers
        text *= alphabet[number]
    end
    return lowercase(text)
end

"""Шифрование конечной гаммой"""
function Cipher_Gamma(Message::String, Gamma::String, Alphabet::StepRange{Char, Int64} = alphabet)::String
    Message_Numbers = Text_to_Numbers(Message, Alphabet)
    Gamma_Numbers = Text_to_Numbers(Gamma, Alphabet)
    modulo = length(Alphabet)
    Encrypted_Numbers = []
    for i ∈ 1:length(Message_Numbers)
        encrypted_number = (Message_Numbers[i] + Gamma_Numbers[(i-1) % length(Gamma_Numbers) + 1]) % modulo
        push!(Encrypted_Numbers, encrypted_number == 0 ? modulo : encrypted_number)
    end
    return Numbers_to_Text(Encrypted_Numbers, Alphabet)
end

"""Дешифрование сообщения, зашифрованного конечной гаммой"""
function Decipher_Gamma(Encrypted_Message::String, Gamma::String, Alphabet::StepRange{Char, Int64} = alphabet)::String
    Encrypted_Numbers = Text_to_Numbers(Encrypted_Message, Alphabet)
    Gamma_Numbers = Text_to_Numbers(Gamma, Alphabet)
    modulo = length(Alphabet)
    Message_Numbers = []
    for i ∈ 1:length(Encrypted_Numbers)
        message_number = (Encrypted_Numbers[i] - Gamma_Numbers[(i-1) % length(Gamma_Numbers) + 1]) % modulo
        push!(Message_Numbers, message_number == 0 ? modulo : message_number)
    end
    return Numbers_to_Text(Message_Numbers, Alphabet)
end

# Пример. Сообщение для шифрования
message = "ПРИКАЗ"  # ("16 17 09 11 01 08")
gamma = "ГАММА"     # ("04 01 13 13 01")
println("Исходное сообщение: ", message, "; Конечная гамма шифрования: ", gamma)
# Шифрование
ciphertext = Cipher_Gamma(message, gamma)
println("Зашифрованное сообщение: ", ciphertext)
# Дешифрование
decrypted_message = Decipher_Gamma(ciphertext, gamma)
println("Расшифрованное сообщение: ", decrypted_message)