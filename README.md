# qemu-bootloader
> Кастомный загрузчик для QEMU, эмулирующего процессор 8086

Результат компоновки знаний, полученных из [cfenollosa/os-tutorial](https://github.com/cfenollosa/os-tutorial) (темы 00-06, основная структура, регистры, управление памятью, вывод текста, управляющие конструкции) и [отсюда](https://habr.com/ru/post/442428/) (алгоритм ввода с клавиатуры и последующего анализа данных).

Но код на Хабре -- ебота с ошибками и бессвязными фрагментами (классика), поэтому пришлось выправлять. Например, было пропадание строки ввода после нажатия Enter, сравнение строк подвешивало виртуальную машину и многое другое.

Также, я сделал покраску экрана и организовал всё в удобные функции. И `Makefile`, на всякий случай.

-----

Сделано для зачёта по предмету **"Стандартизация и сертификация информационных технологий"**.
