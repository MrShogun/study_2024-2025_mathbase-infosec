alphabet = 'a':'z'  # Алфавит
function Caesar_Cipher(Input_Message::String, key::Int)::String
    # Зашифрованное сообщение
    Cipher = String[]
    for char ∈ lowercase(Input_Message)
        if char ∈ alphabet
            position = findfirst(x -> x == char, alphabet)
            # осуществляем сдвиг согласно ключу key
            new_position = mod1(position + key, length(alphabet))
            push!(Cipher, string(alphabet[new_position]))
        else
            push!(Cipher, string(char))  # Символ не из алфавита остаётся неизменным
        end
    end
    return join(Cipher)
end

function Atbash_Cipher(Input_Message::String)::String
    # Зашифрованное сообщение
    Cipher = String[]
    Reversed_alphabet = reverse(alphabet)
    for char ∈ lowercase(Input_Message)
        if char ∈ alphabet
            position = findfirst(x -> x == char, alphabet)
            # осуществляем сдвиг на весь алфавит
            push!(Cipher, string(Reversed_alphabet[position]))
        else
            push!(Cipher, string(char))  # Символ не из алфавита остаётся неизменным
        end
    end
    return join(Cipher)
end

Test_Message = "Veni, vidi, vici"
Test_Key = 3
println("Исходное сообщение: ", Test_Message)
println("Шифр Цезаря с ключом $(Test_Key): ", Caesar_Cipher(Test_Message, Test_Key))
println("Обратно расшифрованное сообщение: ", Caesar_Cipher(Caesar_Cipher(Test_Message, Test_Key), length(alphabet) - Test_Key))
Message_1 = "Si vis pacem, para bellum"
Key_1 = 6
println("\n Исходное сообщение: ", Message_1)
println("Шифр Цезаря с ключом $(Key_1): ", Caesar_Cipher(Message_1, Key_1))
println("Обратно расшифрованное сообщение: ", Caesar_Cipher(Caesar_Cipher(Message_1, Key_1), length(alphabet) - Key_1))

println("\n\nИсходное сообщение: ", Test_Message)
println("Шифр Атбаша: ", Atbash_Cipher(Test_Message))
println("Обратно расшифрованное сообщение: ", Atbash_Cipher(Atbash_Cipher(Test_Message)))
Message_1 = "Si vis pacem, para bellum"
Key_1 = 6
println("\n Исходное сообщение: ", Message_1)
println("Шифр Атбаша: ", Atbash_Cipher(Message_1))
println("Обратно расшифрованное сообщение: ", Atbash_Cipher(Atbash_Cipher(Message_1)))