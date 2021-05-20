%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0
section .rodata
        message db "C'est un proverbe francais.", 10, 0
section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
task1:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov edx, [ebp + 12]
    xor ebx, ebx
    ;mov ebx, 47   ;aici trb 0
key:
    ;PRINT_DEC 4, ebx
    inc ebx
    push edx
    push ebx
    push eax
    xor edx, edx
    call find
    pop eax
    pop ebx
    pop edx
    cmp ebx, 256    ;aici trb 256
    jne key
    
    leave
    ret
    
find:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    xor ecx, ecx
    add ecx, [img_width]
    imul ecx, [img_height]
width:
    xor [eax], ebx
    add eax, 4
    loop width
    push dword[ebp + 8]
    call verify
    add esp, 4
    cmp ebx, 1
    je print
    jmp done2
print:
    mov ebx, eax
    cmp byte[ebp + 16], 2
    je task2
    push ebx
    imul ebx, [img_width]
    mov eax, [ebp + 8]
    printloop:
    cmp byte[eax + ebx * 4], 0
    je done1
    PRINT_CHAR [eax + ebx * 4]
    inc ebx
    jmp printloop
    done1:
    NEWLINE
    PRINT_DEC 4, [ebp + 12]
    NEWLINE
    pop ebx
    PRINT_DEC 4, ebx
    jmp done2
task2:
    mov eax, [ebp + 8]
    inc ebx
    ;PRINT_DEC 4, ebx
    imul ebx, [img_width]
    xor ecx, ecx
    xor edx, edx
write:
    mov dl, byte[message + ecx]
    mov dword[eax + ebx * 4], edx
    inc ebx
    inc ecx
    cmp ecx, 27
    jne write
    mov byte[eax + ebx * 4], 0x0;
    mov eax, [ebp + 12]
    ;PRINT_DEC 4, eax
    imul eax, 2
    add eax, 3
    xor edx, edx
    mov ebx, 5
    ;PRINT_DEC 4, eax
    div ebx
    sub eax, 4
    ;PRINT_DEC 4, eax
    mov ebx, eax
    ;PRINT_DEC 4, ebx
    mov eax, [ebp + 8]
    xor ecx, ecx
    add ecx, [img_width]
    imul ecx, [img_height]
    encode:
    xor [eax], ebx
    add eax, 4
    loop encode
    mov eax, [ebp + 8]
    xor ecx, ecx
    add ecx, [img_width]
    imul ecx, [img_height]
    afis:
        ;PRINT_DEC 4, [eax]
        ;PRINT_STRING " "
        add eax, 4
        dec ecx
        cmp ecx, 0 
       jne afis
    jmp end
    
done2:
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    xor ecx, ecx
    add ecx, [img_width]
    imul ecx, [img_height]
    revert:
    xor [eax], ebx
    add eax, 4
    loop revert
    end:
    leave
    ret

verify:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ecx, [img_width]
    imul ecx, [img_height]
    xor ebx, ebx
checkr:
    inc ebx
    cmp byte[eax + ebx * 4], 'r'
    je checke
    cmp ebx, ecx
    jne checkr
    jmp notfound
checke:
    inc ebx
    cmp byte[eax + ebx * 4], 'e'
    je checkv
    cmp ebx, ecx
    jne checkr
    jmp notfound
checkv:
    inc ebx
    cmp byte[eax + ebx * 4], 'v'
    je checki
    cmp ebx, ecx
    jne checkr
    jmp notfound
checki:
    inc ebx
    cmp byte[eax + ebx * 4], 'i'
    je checke2
    cmp ebx, ecx
    jne checkr
    jmp notfound
checke2:
    inc ebx
    cmp byte[eax + ebx * 4], 'e'
    je checkn
    cmp ebx, ecx
    jne checkr
    jmp notfound
checkn:
    inc ebx
    cmp byte[eax + ebx * 4], 'n'
    je checkt
    cmp ebx, ecx
    jne checkr
    jmp notfound
checkt:
    inc ebx
    cmp byte[eax + ebx * 4], 't'
    je found
    cmp ebx, ecx
    jne checkr
    jmp notfound
found:
    mov eax, ebx
    div dword[img_width]
    mov ebx, 1
notfound:            
    leave
    ret

task3:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ebx, [ebp + 16]
    imul ebx, 4
    add eax, ebx
    mov ebx, [ebp + 12]
    jump:
    ;PRINT_STRING "y"
    cmp byte [ebx], 0x0
    je niet
    cmp byte[ebx], 'A'
    je A
    cmp byte[ebx], 'B'
    je B
    cmp byte[ebx], 'C'
    je C
    cmp byte[ebx], 'D'
    je D
    cmp byte[ebx], 'E'
    je E
    cmp byte[ebx], 'F'
    je F
    cmp byte[ebx], 'G'
    je G
    cmp byte[ebx], 'H'
    je H
    cmp byte[ebx], 'I'
    je I
    cmp byte[ebx], 'J'
    je J
    cmp byte[ebx], 'K'
    je K
    cmp byte[ebx], 'L'
    je L
    cmp byte[ebx], 'M'
    je M
    cmp byte[ebx], 'N'
    je N
    cmp byte[ebx], 'O'
    je O
    cmp byte[ebx], 'P'
    je P
    cmp byte[ebx], 'Q'
    je Q
    cmp byte[ebx], 'R'
    je R
    cmp byte[ebx], 'S'
    je S
    cmp byte[ebx], 'T'
    je T
    cmp byte[ebx], 'U'
    je U
    cmp byte[ebx], 'V'
    je V
    cmp byte[ebx], 'W'
    je W
    cmp byte[ebx], 'X'
    je X
    cmp byte[ebx], 'Y'
    je Y
    cmp byte[ebx], 'Z'
    je Z
    cmp byte[ebx], '1'
    je C1
    cmp byte[ebx], '2'
    je C2
    cmp byte[ebx], '3'
    je C3
    cmp byte[ebx], '4'
    je C4
    cmp byte[ebx], '5'
    je C5
    cmp byte[ebx], '6'
    je C6
    cmp byte[ebx], '7'
    je C7
    cmp byte[ebx], '8'
    je C8
    cmp byte[ebx], '9'
    je C9
    cmp byte[ebx], '0'
    je C0
    cmp byte[ebx], ','
    je Virgula
    inc ebx
    jmp jump
    A:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    B:
    mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C:

    mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
        mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    D:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    E:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    F:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
        mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    G:
        mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '-'
    add eax, 4
        mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
        H:
        mov dword[eax], '.'
    add eax, 4
            mov dword[eax], '.'
    add eax, 4
            mov dword[eax], '.'
    add eax, 4
            mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    I:
            mov dword[eax], '.'
    add eax, 4
            mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    J:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    K:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    L:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    M:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    N:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    O:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    P:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    Q:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    R:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    S:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    T:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    U:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    V:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    W:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    X:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    Y:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    Z:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C1:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C2:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C3:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C4:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C5:
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C6:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C7:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C8:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C9:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    C0:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    Virgula:
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '.'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], '-'
    add eax, 4
    mov dword[eax], ' '
    add eax, 4
    inc ebx
    jmp jump
    
    niet:
    mov dword[eax - 4], 0x0
    leave
    ret
    
task4:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ebx, [ebp + 16]
    imul ebx, 4
    add eax, ebx
    sub eax, 4
    mov ebx, [ebp + 12]
lsb:
    cmp byte[ebx], 0x0
    je fin
    mov ecx, 8
    ;PRINT_HEX 1, [ebx]
    octet:
    xor edx, edx
    mov dl, 0x80
    and dl, byte[ebx]
    shr dl, 7
    ;PRINT_DEC 1, dl
    and byte[eax], 0xFE
    or byte[eax], dl
    shl byte[ebx], 1
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne octet
    inc ebx
    jmp lsb
    
    fin:
    mov ecx, 8
    nullt:
    and byte[eax], 0xFE
    add eax, 4
    loop nullt
    leave
    ret
    
task5:
    push ebp
    mov ebp, esp
    ;PRINT_STRING "YAAAY"
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    imul ebx, 4
    add eax, ebx
    sub eax, 4
    ;PRINT_DEC 4, [eax]
    go:
    mov ecx, 8
    xor ebx, ebx
    char:
    xor edx, edx
    mov dl, 0x1
    and dl, byte[eax]
    ;PRINT_DEC 1, dl
    add bl, dl
    shl bl, 1
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne char
    cmp bl, 0x0
    je stop
    shr bl, 1
    PRINT_CHAR bl
    jmp go
    stop:
    leave
    ret 

task6:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    mov ecx, [img_width]
    imul ecx, 4
    add ebx, ecx
    add ebx, 4
    mov ecx, [img_height]
    first:
    mov edx, [img_width]
    second:
    push edx
    mov edx, [img_width]
    imul edx, 4
    sub ebx, edx
    mov eax, [ebx]
    add ebx, edx
    add eax, [ebx]
    mov edx, [img_width]
    add eax, [ebx + edx * 4]
    add eax, [ebx + 4]
    add eax, [ebx - 4]
    push ecx
    xor edx, edx
    mov ecx, 5
    div ecx
    pop ecx
    pop edx
    ;PRINT_DEC 4, eax
    ;PRINT_STRING " "
    push eax
    add ebx, 4
    dec edx
    cmp edx, 2
    jne second
    add ebx, 8
    dec ecx
    cmp ecx, 2
    jne first
    
    sub ebx, 12
    ;mov ebx, [ebp + 8]
    ;mov ecx, [img_width]
    ;imul ecx, 4
    ;add ebx, ecx
    ;add ebx, 4
    mov ecx, [img_height]
    unu:
    mov edx, [img_width]
    doi:
    pop dword[ebx]
    sub ebx, 4
    dec edx
    cmp edx, 2
    jne doi
    sub ebx, 8
    dec ecx
    cmp ecx, 2
    jne unu   
    
    
    
    leave
    ret
          
    
global main
main:
    mov ebp, esp; for correct debugging
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    ; TODO Task1
    push 1
    push dword[img]
    call task1
    add esp, 8
    jmp done
solve_task2:
    ; TODO Task2
    push 2
    push dword[img]
    call task1
    add esp, 8
    push dword[img_height]
    push dword[img_width]

    push dword[img]
    call print_image
    add esp, 12
    jmp done
solve_task3:
    ; TODO Task3
    xor edx, edx
    mov edx, dword[ebp + 12]
    push dword[edx + 16]
    call atoi
    add esp, 4
    push eax
    mov edx, dword[ebp + 12]
    mov edx, [edx + 12]
    push edx
    push dword[img]
    ;PRINT_DEC 4, [ebp + 8]
    call task3
    add esp, 12
    push dword[img_height]
    push dword[img_width]

    push dword[img]
    call print_image
    add esp, 12
    jmp done
solve_task4:
    ; TODO Task4
    xor edx, edx
    mov edx, dword[ebp + 12]
    push dword[edx + 16]
    call atoi
    add esp, 4
    push eax
    mov edx, dword[ebp + 12]
    mov edx, [edx + 12]
    push edx
    push dword[img]
    call task4
    add esp, 12
    push dword[img_height]
    push dword[img_width]

    push dword[img]
    call print_image
    add esp, 12
    jmp done
solve_task5:
    ; TODO Task5
    xor edx, edx
    mov edx, dword[ebp + 12]
    push dword[edx + 12]
    call atoi
    add esp, 4
    push eax
    push dword[img]
    call task5
    add esp, 12
    jmp done
solve_task6:
    ; TODO Task6
    push dword[img]
    call task6
    add esp, 4
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    add esp, 12
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
