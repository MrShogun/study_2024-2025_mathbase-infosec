---
## Front matter
title: "Лабораторная работа №3"
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

Получение практических навыков работы в консоли с атрибутами файлов для групп пользователей.

# Выполнение лабораторной работы

1. Во второй лабораторной работе уже была создана учётная запись пользователя guest (useradd guest) и задан пароль для него (passwd guest). Действуя согласно [-@lab3], создадим второго пользователя guest2 ([-@fig:001]).

    ![Создание учётной записи guest2](image/1.png){#fig:001 width=70%}

2. Добавим пользователя guest2 в группу guest командой gpasswd -a guest2 guest ([-@fig:002]).

    ![Добавление guest2 в группу guest](image/2.png){#fig:002 width=70%}

3. Войдём в систему от двух пользователей на двух разных консолях: guest на первой консоли ([-@fig:003]) и guest2 на второй консоли ([-@fig:004]).

    ![Вход в систему от имени guest](image/3.png){#fig:003 width=70%}

    ![Вход в систему от имени guest2](image/4.png){#fig:004 width=70%}

4. Для guest ([-@fig:005]) и guest2 ([-@fig:006]) командой pwd определим директорию, в которой находимся.

    ![Директория нахождения guest](image/5.png){#fig:005 width=70%}

    ![Директория нахождения guest2](image/6.png){#fig:006 width=70%}

5. Уточним для первого ([-@fig:007]) и второго ([-@fig:008]) пользователя имя, его группу, кто входит в неё и к каким группам принадлежит он сам. Определим также к каким группам принадлежат пользователи guest ([-@fig:009]) и guest2 ([-@fig:010]) командами groups guest и groups guest2. Теперь сравним вывод команды groups с выводом команд id -Gn и id -G для первого ([-@fig:011]) и второго пользователей ([-@fig:012]). Нетрудно заметить, что команда id -G выводит код группы пользователей, тогда как остальные только название.

    ![Имя, группа и id пользователя guest](image/7.png){#fig:007 width=70%}

    ![Имя, группа и id пользователя guest2](image/8.png){#fig:008 width=70%}

    ![Группы пользователя guest](image/9.png){#fig:009 width=70%}

    ![Группы пользователя guest2](image/10.png){#fig:010 width=70%}

    ![Группы и id пользователя guest](image/11.png){#fig:011 width=70%}

    ![Группы и id пользователя guest2](image/12.png){#fig:012 width=70%}

6. Сравним полученную информацию с содержимым файла /etc/group, просмотрев файл командой cat /etc/group ([-@fig:013]). Как видим, полученная информация совпадает с выводом из предыдущего пункта.

    ![Содержимое файла /etc/group](image/13.png){#fig:013 width=70%}

7. Выполним регистрацию пользователя guest2 в группе guest от имени пользователя guest2 командой newgrp guest ([-@fig:014]).

    ![Регистрация пользователя guest2 в группе guest](image/14.png){#fig:014 width=70%}

8. Изменим права директории /home/guest, разрешив все действия для пользователей группы от имени пользователя guest, воспользовавшись командой chmod g+rwx /home/guest ([-@fig:015]).

    ![Установка максимальных прав доступа для пользователей группы](image/15.png){#fig:015 width=70%}

9. Снимем с директории /home/guest/dir1 все атрибуты командой chmod 000 dir1 и проверим правильность снятия атрибутов от имени пользователя guest ([-@fig:016]).

    ![Снятие всех атрибутов с директории dir1](image/16.png){#fig:016 width=70%}

10. Меняя атрибуты у директории dir1 и файла file1 от имени пользователя guest и делая проверку от пользователя guest2, заполним таблицу, определив опытным путём, какие операции разрешены, а какие нет. Если операция разрешена, будем заносить в таблицу знак «+», если не разрешена --- знак «-» ([-@fig:017]).

    ![Установленные права и разрешённые действия](image/17.png){#fig:017 width=100%}

    Сравнив полученную таблицу с таблицей из предыдущей лабораторной работы, можно сделать вывод, что таблицы не совпадают, так как у членов группы нет прав изменять атрибуты файла. Также обратим внимание, что атрибуты файла, не созданного пользователем guest2, невозможно изменить при любых правах (для созданного --- требуются права на исполнение у директории).

11. На основании заполненной таблицы ([-@fig:017]) определим минимально необходимые права для выполнения пользователем guest2 операций внутри директории dir1 и заполним таблицу ([-@fig:018]).

    ![Минимально необходимые права для выполнения операций пользователем guest2](image/18.png){#fig:018 width=70%}

# Выводы

В ходе выполнения лабораторной работы я получил практические навыки работы в консоли с атрибутами файлов для групп пользователей.

# Список литературы{.unnumbered}

::: {#refs}
:::
