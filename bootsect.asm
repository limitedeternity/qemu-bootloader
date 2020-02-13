[org 0x7c00]
[cpu 8086]
[bits 16]

jmp short start
nop

; Таблица файловой системы
OEMLabel		    db "Example "	; Disk label
BytesPerSector		dw 512		; Bytes per sector
SectorsPerCluster	db 1		; Sectors per cluster
ReservedForBoot		dw 1		; Reserved sectors for boot record
NumberOfFats		db 2		; Number of copies of the FAT
RootDirEntries		dw 224		; Number of entries in root dir
LogicalSectors		dw 2880		; Number of logical sectors
MediumByte		    db 0x0F0		    ; Medium descriptor byte
SectorsPerFat		dw 9		; Sectors per FAT
SectorsPerTrack		dw 18		; Sectors per track (36/cylinder)
Sides			    dw 2		    ; Number of sides/heads
HiddenSectors		dd 0		; Number of hidden sectors
LargeSectors		dd 0		; Number of LBA sectors
DriveNo			    dw 0		    ; Drive No: 0
Signature		    db 41		    ; Drive signature: 41 for floppy
VolumeID		    dd 0x00000000	; Volume ID: any number
VolumeLabel		    db "Example    "; Volume Label: any 11 chars
FileSystem		    db "FAT12   "	; File system type: don't change!
; --------------------

start:
    ; Инициализация регистров
    cli
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov sp, 0x6ef0
    sti
    ; --------------------

    ; сброс дисковой системы (для учёта сдвигов)
    mov ah, 0
    int 0x13

    ; прочесть ядро и записать в оперативную память
    mov bx, 0x7e00 ; адрес расположения ядра (куда записать)
    mov al, 1 ; прочесть 1 сектор
    mov ch, 0 ; 0 дорожка
    mov dh, 0 ; 0 головка
    mov cl, 2 ; выбрать 2 сектор
    mov ah, 2 ; прочесть с диска
    int 0x13
    jmp 0x7e00 ; прыгаем


%assign used_mem ($-$$)
%assign usable_mem 510
%warning [used_mem/usable_mem] bytes used
times 510-($-$$) db 0
db 0x55
db 0xAA

