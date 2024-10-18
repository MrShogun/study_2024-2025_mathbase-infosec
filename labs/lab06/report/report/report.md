---
## Front matter
title: "Лабораторная работа №6"
subtitle: "Математические основы защиты информации и информационной безопасности"
author: "Николаев Дмитрий Иванович, НПМмд-02-24"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

Изучить работу алгоритмов разложения чисел на множители: $\rho$-Метод Полларда; Метод квадратов (Теорема Ферма о разложении); а также реализовать их программно.

# Теоретическое введение

## Разложение чисел на множители

Задача разложения на множители — одна из первых задач, использованных для построения криптосистем с открытым ключом.

Задача разложения составного числа на множители формулируется следующим образом: для данного положительного целого числа $n$ найти его каноническое разложение $n = p_1^{\alpha_1} p_2^{\alpha_2} \dots p_s^{\alpha_s}$, где $p_i$ — попарно различные числа $\alpha_i \geq 1$.

На практике не обязательно находить каноническое разложение числа $n$. Достаточно найти его разложение на два нетривиальных сомножителя: $n = pq$, $1 \leq p \leq q < n$. Далее будем понимать задачу разложения именно в этом смысле.

## $\rho$-Метод Полларда

Пусть $n$ — нечетное составное число, $S = {0, 1, \dots, n - 1}$ и $f: S \to S$ — случайное отображение, обладающее сжимающими свойствами, например $f(x) = x^2 + 1 \mod n$. Основная идея метода состоит в следующем. Выбираем случайный элемент $x_0 \in S$ и строим последовательность $x_0, x_1, x_2, ...$, определяемую рекуррентным соотношением:

$$
x_{i+1} = f(x_i),
$$
где $i \geq 0$, до тех пор, пока не найдем такие числа $i, j$, что $i < j$ и $x_i = x_j$. Поскольку множество $S$ конечно, такие индексы $i, j$ существуют (последовательность "зацикливается"). Последовательность $\{x_i\}$ будет состоять из "хвоста" $x_0, x_1, ..., x_{i-1}$ длины $O(\sqrt{\frac{\pi n}{8}})$ и цикла $x_i = x_j, x_{i+1}, ..., x_{j-1}$ той же длины.

### Алгоритм, реализующий $\rho$-Метод Полларда

**Вход:** Число $n$, начальное значение $c$, функция $f$, обладающая сжимающими свойствами.

**Выход:** Нетривиальный делитель числа $n$.

1. Положить $a \gets c$, $b \gets c$.
2. Вычислить $a \gets f(a) \mod n$, $b \gets f(f(b)) \mod n$.
3. Найти $d \gets \text{НОД}(a - b, n)$.
4. Если $1 < d < n$, то положить $p \gets d$ и результат: $p$. При $d = n$ — "Делитель не найден"; при $d = 1$ вернуться на шаг 2.

### Пример

Найти $\rho$-методом Полларда нетривиальный делитель $1359331$. Положим $c = 1$ и $f(x) = x^2 + 5 \mod n$. Работа иллюстрируется следующей последовательностью:

1. Рассмотрим первый цикл алгоритма
    1. $a = 1$, $b = 1$;
    2. $a \equiv 1^2 + 5 \mod n \equiv 6$, $b \equiv f(1^2 + 5 \mod n) \equiv 6^2 + 5 \mod n \equiv 41$;
    3. $d = \text{НОД}(a - b, n) = \text{НОД}(6 - 41, n) = 1$;
    4. $d = 1$, значит возвращаемся на второй шаг.
2. Рассмотрим второй цикл алгоритма
    1. $a \equiv 6^2 + 5 \mod n \equiv 41$, $b \equiv 123939$;
    2. $d = \text{НОД}(a - b, n) = 1$;
3. Рассмотрим третий цикл алгоритма
    1. $a \equiv 41^2 + 5 \mod n \equiv 1686$, $b \equiv 391594$;
    2. $d = \text{НОД}(a - b, n) = 1$;
4. Рассмотрим четвёртый цикл алгоритма
    1. $a \equiv 1686^2 + 5 \mod n \equiv 123939$, $b \equiv 438157$;
    2. $d = \text{НОД}(a - b, n) = 1$;
5. Рассмотрим пятый цикл алгоритма
    1. $a \equiv 123939^2 + 5 \mod n \equiv 435426$, $b \equiv 582738$;
    2. $d = \text{НОД}(a - b, n) = 1$;
6. Рассмотрим шестой цикл алгоритма
    1. $a \equiv 435426^2 + 5 \mod n \equiv 391594$, $b \equiv 1144026$;
    2. $d = \text{НОД}(a - b, n) = 1$;
7. Рассмотрим седьмой цикл алгоритма
    1. $a \equiv 391594^2 + 5 \mod n \equiv 1090062$, $b \equiv 885749$;

Таким образом, $p = \text{НОД}(a - b, n) = \text{НОД}(1090062 - 885749, 1359331) = 1181$ является нетривиальным делителем числа $1359331$.

## Метод квадратов (Теорема Ферма о разложении)

Для любого положительного нечетного числа $n$ существует взаимно однозначное соответствие между множеством делителей числа $n$, не меньших, чем $\sqrt{n}$, и множеством пар $\{s, t\}$ таких неотрицательных целых чисел, что $n = s^2 - t^2$.

### Пример

У числа $15$ два делителя, не меньших, чем $\sqrt{15}$ — это числа $5$ и $15$. Тогда получаем два представления:

1. $15 = pq = 3 \cdot 5$, откуда $s = 4$, $t = 1$ и $15 = 4^2 - 1^2$;
2. $15 = pq = 1 \cdot 15$, откуда $s = 8$, $t = 7$ и $15 = 8^2 - 7^2$.

# Выполнение лабораторной работы

Действуя согласно [-@lab6], реализуем все описанные алгоритмы на языке Julia.

# Выводы

В ходе выполнения лабораторной работы я изучил работу алгоритмов разложения чисел на множители: $\rho$-Метод Полларда; Метод квадратов (Теорема Ферма о разложении); а также реализовал их программно.

# Список литературы{.unnumbered}

::: {#refs}
:::
