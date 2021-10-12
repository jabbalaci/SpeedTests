SYS_EXIT  equ 60
SYS_WRITE equ 1
STDOUT    equ 1
SUCCESS   equ 0

N equ 440000000

section .text
  global _start

_start:
  xor eax, eax
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
    mov rbx, cache
    mov rcx, [i]
    mov [rbx+4*rcx], eax
    inc dword [i]
    cmp dword [i], 10
    jl prepare_cache

  xor eax, eax
  mov [i], eax
  main_loop:
    mov eax, [i]
    call is_munchausen
    cmp eax, 0
    jne yes_it_is
    jmp main_loop_end
    yes_it_is:
      mov rax, [i]
      call print_number
      call print_newline
    main_loop_end:
      inc dword [i]
      cmp dword [i], N
      jl main_loop

  mov rax, SYS_EXIT
  mov rdi, SUCCESS
  syscall

is_munchausen:
  mov [number], eax
  mov [n], eax
  xor eax, eax
  mov [total], eax

  loop:
    mov eax, [n]
    xor edx, edx
    div dword [const10]
    mov [n], eax
    mov rbx, cache
    mov ecx, edx
    mov eax, [rbx+4*rcx]
    add [total], eax

    mov eax, [number]
    cmp [total], eax
    jg ret_0

    cmp dword [n], 0
    jg loop

  mov eax, [number]
  cmp dword [total], eax
  je ret_1

  ret_0:
    xor eax, eax
    ret

  ret_1:
    mov eax, 1
    ret

print_newline:
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, newline
  mov rdx, 1
  syscall
  ret

print_number:
  push rax
  push rdx
  xor rdx, rdx
  div dword [const10]
  cmp rax, 0
  je l1
  call print_number
  l1:
  mov [char], rdx
  add byte [char], '0'

  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, char
  mov rdx, 1
  syscall

  pop rdx
  pop rax
  ret

section .data
  const10 dq 10
  newline db 0xa

section .bss
  i resd 1
  cache resd 10
  n resd 1
  number resd 1
  total resd 1
  char resb 1
