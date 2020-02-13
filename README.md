# qemu-bootloader
> Кастомный загрузчик для QEMU, эмулирующего процессор 8086

Результат компоновки знаний, полученных из [cfenollosa/os-tutorial](https://github.com/cfenollosa/os-tutorial) (темы 00-07, основная структура, регистры, управление памятью, вывод текста, управляющие конструкции) и [отсюда](https://habr.com/ru/post/442428/) (алгоритм ввода с клавиатуры и последующего анализа данных).

Но код на Хабре -- ебота с ошибками и бессвязными фрагментами (классика), поэтому пришлось выправлять. Например, было пропадание строки ввода после нажатия Enter, сравнение строк подвешивало виртуальную машину и многое другое.

Также, я сделал покраску экрана и организовал всё в удобные функции. И `Makefile`, на всякий случай.

![Screenshot at Feb 13 12-16-54](https://user-images.githubusercontent.com/24318966/74419332-c6f21b00-4e5a-11ea-8f64-2f5dca12b965.png)

-----

Сделано для зачёта по предмету **"Стандартизация и сертификация информационных технологий"**.
