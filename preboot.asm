[org 0x7e00]
[cpu 8086]
[bits 16]

call cls
call sleep 
mov si, GREET
call print

mov bx, 0 ; инициализируем bx как индекс для хранения ввода
jmp short get_input

; ------

get_input:
    mov si, ARROW
    call print
    call input_processing
    jmp get_input

input_processing:
    mov ah, 0x00 ; параметр для 16h
    int 0x16

    cmp al, 0x0d ; Enter
    je check_input

    cmp al, 0x8 ; Backspace
    je backspace

    cmp al, 0x3 ; Ctrl+C
    je halt

    mov ah, 0x0e ; В противном случае выводим символ на печать
    int 0x10

    mov [INPUT+bx], al ; Вписываем символ в буфер ввода
    add bx, 1 ; Увеличиваем индекс
    cmp bx, 64 ; Чекаем переполнение
    je check_input

    jmp input_processing

check_input:
    add bx, 1 ; Нужно в конец буфера вкинуть \0, чтобы получилась строка
    mov byte [INPUT+bx], 0
    
    mov si, NL ; Переход на новую строку в консоли
    call print
   
    mov bx, INPUT

    ; Блок halt
    mov si, HALT_CMD
    call cmp_si_bx
    cmp cx, 1
    je halt
    
    ; Блок help
    mov si, HELP_CMD
    call cmp_si_bx
    cmp cx, 1
    je help_matched

    ; Блок boot
    mov si, BOOT_CMD
    call cmp_si_bx
    cmp cx, 1
    je boot_matched

    ; Команда не найдена
    jmp no_match

cmp_si_bx:
    mov ah, [bx] ; мы не можем сравнить два байта напрямую, поэтому используем ah в качестве временного хранилища
    cmp [si], ah ; теперь можем
    jne not_equal
    cmp byte [si], 0
    je zero_reached
    add si, 1 ; двигаемся по si дальше, если не добрались до \0
    add bx, 1 ; двигаемся по bx дальше
    jmp cmp_si_bx

zero_reached:
    cmp byte [bx], 0
    jne not_equal
    mov cx, 1
    ret

not_equal:
    mov cx, 0
    ret

backspace:
    cmp bx, 0 ; возвращаемся назад, если стирать нечего
    je input_processing

    mov ah, 0x0e     
    int 0x10

    mov al, ' ' ; печатаем пробел, чтобы стереть символ
    int 0x10

    mov al, 0x8 ; не даём каретке вернуться назад
    int 0x10

    sub bx, 1 ; уменьшаем индекс
    mov byte [INPUT+bx], 0 ; срезаем введенные данные
    jmp input_processing ; прыгаем назад

halt:
    mov si, GOODBYE
    call print
    call sleep
    mov ax, 0x5307 ; управление питанием
    mov bx, 0x0001 ; всех устройств
    mov cx, 0x0003 ; выключить
    int 0x15

help_matched:
    mov si, HELP_MSG
    call print
    jmp clean

boot_matched:
    call cls
    call sleep
    int 0x18

no_match:
    mov si, WRONG_CMD
    call print
    jmp clean

clean:
    cmp bx, 0
    je break
    sub bx, 1
    mov byte [INPUT+bx], 0
    jmp clean

print:
    mov al, [si]
    cmp al, 0
    je break
    mov ah, 0x0e
    int 0x10
    add si, 1
    jmp print

cls:
    mov ah, 0x00 ; очистка экрана
    mov al, 0x03
    int 0x10

    mov ah, 0x09 ; покрас экрана
    mov cx, 0x1000
    mov al, 0x20 ; зелёный на чёрном (https://en.wikipedia.org/wiki/BIOS_color_attributes)
    mov bl, 0x02
    int 0x10
    ret

break:
    ret

sleep:
    mov cx, 0x0F
    mov dx, 0x4240
    mov ah, 0x86
    int 0x15
    ret


ARROW:
    db '$> ', 0

GREET:
    db "Type '?' for commands", 0x0d, 0x0a, 0x0a, 0

WRONG_CMD:
    db 'Unknown command', 0x0d, 0x0a, 0

HELP_MSG:
    db 'Known commands: boot, halt', 0x0d, 0x0a, 0

HELP_CMD: 
    db '?', 0

BOOT_CMD:
    db 'boot', 0

HALT_CMD:
    db 'halt', 0

GOODBYE:
    db 0x0d, 0x0a, 0x0d, 0x0a, 'Process halted', 0x0d, 0x0a, 0

NL:
    db 0x0d, 0x0a, 0

INPUT: 
    times 64 db 0


%assign used_mem ($-$$)
%assign usable_mem 512
%warning [used_mem/usable_mem] bytes used
times 512-($-$$) db 0

