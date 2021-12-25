format ELF executable 3

define SYS_EXIT  1
define SYS_WRITE 4
define STDOUT    1
define SUCCESS   0

define N 440000000

segment readable executable
  entry start

start:
  mov eax, 0
  mov [i], eax

  prepare_cache:
    mov eax, [i]
    mov ebx, [i]
    mov ecx, 1
    exponentiation:
      mul ebx
      inc ecx
      cmp ecx, [i]
      jl exponentiation
    mov ebx, cache
    mov ecx, [i]
    mov [ebx+4*ecx], eax
    inc dword [i]
    cmp dword [i], 10
    jl prepare_cache

  mov eax, 0
  mov [i], eax
  main_loop:
    mov eax, [i]
    call is_munchausen
    cmp eax, 0
    jne yes_it_is
    jmp main_loop_end
    yes_it_is:
      mov eax, [i]
      call print_number
      call print_newline
    main_loop_end:
      inc dword [i]
      cmp dword [i], N
      jl main_loop

  mov eax, SYS_EXIT
  mov ebx, SUCCESS
  int 0x80

is_munchausen:
  mov [number], eax
  mov [n], eax
  mov eax, 0
  mov [total], eax

  loop0:
    mov eax, [n]
    mov edx, 0
    div dword [const10]
    mov [n], eax
    mov ebx, cache
    mov ecx, edx
    mov eax, [ebx+4*ecx]
    add [total], eax

    mov eax, [number]
    cmp [total], eax
    jg ret_0

    cmp dword [n], 0
    jg loop0

  mov eax, [number]
  cmp dword [total], eax
  je ret_1

  ret_0:
    mov eax, 0
    ret

  ret_1:
    mov eax, 1
    ret

print_newline:
  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov ecx, newline
  mov edx, 1
  int 0x80
  ret

print_number:
  push eax
  push edx
  xor edx, edx
  div dword [const10]
  cmp eax, 0
  je l1
  call print_number
  l1:
  mov [char], dl
  add byte [char], '0'

  mov eax, SYS_WRITE
  mov ebx, STDOUT
  mov ecx, char
  mov edx, 1
  int 0x80

  pop edx
  pop eax
  ret

segment readable writable
  const10 dd 10
  newline db 0xa

  i rd 1
  cache rd 10
  n rd 1
  number rd 1
  total rd 1
  char rb 1
