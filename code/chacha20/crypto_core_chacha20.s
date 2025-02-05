 .syntax unified
 .cpu cortex-m4

 .global crypto_core_chacha20
 .type crypto_core_chacha20, %function

crypto_core_chacha20:
        push    {r4, r5, r6, r7, r8, r9, r10, fp, lr}
        sub     sp, sp, #92
        ldr     r4, [r2, #8]      @ unaligned
        str     r0, [sp, #68]
        ldr     r0, [r2, #12]     @ unaligned
        str     r0, [sp, #8]
        ldr     r0, [r3, #8]      @ unaligned
        str     r0, [sp, #24]
        ldr     r0, [r1, #8]      @ unaligned
        str     r0, [sp, #48]
        ldr     r0, [r1, #12]     @ unaligned
        str     r0, [sp, #52]
        ldr     r0, [r1]  @ unaligned
        ldr     r1, [r1, #4]      @ unaligned
        str     r1, [sp, #60]
        ldr     r1, [r2, #16]     @ unaligned
        str     r1, [sp, #32]
        ldr     r1, [r2, #20]     @ unaligned
        ldr     r5, [r3]  @ unaligned
        ldr     r7, [r2]  @ unaligned
        ldr     r6, [r2, #4]      @ unaligned
        str     r4, [sp, #4]
        str     r1, [sp, #36]
        ldr     r4, [r3, #4]      @ unaligned
        ldr     r1, [r2, #24]     @ unaligned
        ldr     r2, [r2, #28]     @ unaligned
        ldr     r3, [r3, #12]     @ unaligned
        str     r0, [sp, #56]
        str     r1, [sp, #40]
        str     r2, [sp, #44]
        str     r7, [sp, #28]
        str     r5, [sp, #72]
        str     r4, [sp, #76]
        ldr     ip, [sp, #4]
        ldr     r9, [sp, #24]
        ldr     r8, [sp, #8]
        ldr     r2, [sp, #48]
        str     r3, [sp, #80]
        add     lr, r7, r5
        add     r10, ip, r9
        ldr     r7, [sp, #60]
        ldr     r9, [sp, #56]
        ldr     ip, [sp, #52]
        ldr     r5, [sp, #44]
        str     r6, [sp, #84]
        add     fp, r8, r3
        adds    r0, r6, r4
        eor     r4, r2, lr
        eor     r2, r9, r10
        eor     r9, r7, fp
        ldr     r7, [sp, #36]
        ldr     r8, [sp, #40]
        eor     r1, ip, r0
        ldr     ip, [sp, #32]
        add     r3, r7, r1, ror #16
        add     r7, r5, r9, ror #16
        ldr     r5, [sp, #28]
        add     ip, ip, r4, ror #16
        eor     r5, r5, ip
        add     lr, lr, r5, ror #20
        eor     r4, lr, r4, ror #16
        add     ip, ip, r4, ror #24
        eor     r5, ip, r5, ror #20
        str     r5, [sp, #12]
        ldr     r5, [sp, #4]
        add     r8, r8, r2, ror #16
        eor     r5, r5, r8
        add     r10, r10, r5, ror #20
        eor     r2, r10, r2, ror #16
        eors    r6, r6, r3
        add     r8, r8, r2, ror #24
        add     r0, r0, r6, ror #20
        eor     r5, r8, r5, ror #20
        eor     r1, r0, r1, ror #16
        add     r0, r0, r5, ror #25
        eor     r4, r0, r4, ror #24
        str     r4, [sp]
        ldr     r4, [sp, #8]
        str     r0, [sp, #16]
        eors    r4, r4, r7
        add     fp, fp, r4, ror #20
        eor     r9, fp, r9, ror #16
        add     r7, r7, r9, ror #24
        eor     r4, r7, r4, ror #20
        add     r10, r10, r4, ror #25
        add     r3, r3, r1, ror #24
        eor     r1, r10, r1, ror #24
        ldr     r0, [sp, #12]
        str     r1, [sp, #12]
        eor     r6, r3, r6, ror #20
        ldr     r1, [sp]
        add     lr, lr, r6, ror #25
        eor     r9, lr, r9, ror #24
        add     r7, r7, r1, ror #16
        ldr     r1, [sp, #12]
        add     r8, r8, r9, ror #16
        add     ip, ip, r1, ror #16
        eor     r6, r8, r6, ror #25
        ldr     r1, [sp, #16]
        eor     r5, r7, r5, ror #25
        add     lr, lr, r6, ror #20
        add     r1, r1, r5, ror #20
        eor     r9, lr, r9, ror #16
        str     lr, [sp, #20]
        add     fp, fp, r0, ror #25
        mov     lr, r9
        str     r1, [sp, #16]
        mov     r9, r1
        ldr     r1, [sp]
        str     lr, [sp, #64]
        eor     r2, fp, r2, ror #24
        eor     r4, ip, r4, ror #25
        add     r3, r3, r2, ror #16
        eor     r9, r9, r1, ror #16
        ldr     r1, [sp, #12]
        eor     r0, r3, r0, ror #25
        add     r10, r10, r4, ror #20
        add     fp, fp, r0, ror #20
        eor     r1, r10, r1, ror #16
        add     r7, r7, r9, ror #24
        eor     r2, fp, r2, ror #16
        add     r8, r8, lr, ror #24
        add     ip, ip, r1, ror #24
        eor     lr, r7, r5, ror #20
        add     r3, r3, r2, ror #24
        str     lr, [sp, #12]
        eor     lr, ip, r4, ror #20
        ldr     r4, [sp, #20]
        eor     r0, r3, r0, ror #20
        add     r4, r4, r0, ror #25
        str     r4, [sp]
        ldr     r4, [sp, #16]
        str     lr, [sp, #16]
        eor     r6, r8, r6, ror #20
        add     r5, r4, r6, ror #25
        ldr     r4, [sp, #12]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        add     r10, r10, r4, ror #25
        eor     r9, lr, r9, ror #24
        eor     r2, r10, r2, ror #24
        ldr     lr, [sp, #12]
        ldr     r4, [sp, #64]
        add     r8, r8, r2, ror #16
        eor     lr, r8, lr, ror #25
        str     lr, [sp, #12]
        eor     r4, fp, r4, ror #24
        ldr     lr, [sp, #16]
        eor     r1, r5, r1, ror #24
        add     r7, r7, r4, ror #16
        str     r1, [sp, #20]
        add     r3, r3, r1, ror #16
        eor     r1, r7, lr, ror #25
        str     r1, [sp, #16]
        ldr     r1, [sp, #12]
        ldr     lr, [sp]
        add     ip, ip, r9, ror #16
        add     r10, r10, r1, ror #20
        ldr     r1, [sp, #16]
        eor     r0, ip, r0, ror #25
        add     lr, lr, r0, ror #20
        eor     r6, r3, r6, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        eor     r1, r5, r1, ror #16
        add     ip, ip, r9, ror #24
        add     r3, r3, r1, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #64]
        eor     r4, fp, r4, ror #16
        ldr     r0, [sp, #16]
        str     r1, [sp]
        eor     r6, r3, r6, ror #20
        add     r1, lr, r6, ror #25
        add     r7, r7, r4, ror #24
        str     r3, [sp, #20]
        eor     r0, r7, r0, ror #20
        ldr     r3, [sp, #12]
        str     r1, [sp, #12]
        eor     r4, r1, r4, ror #24
        ldr     r1, [sp]
        ldr     lr, [sp, #64]
        eor     r2, r10, r2, ror #16
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        str     r1, [sp, #16]
        add     fp, fp, lr, ror #25
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #20]
        add     r8, r8, r2, ror #24
        eor     r2, fp, r2, ror #24
        add     r1, r1, r2, ror #16
        eor     r3, r8, r3, ror #20
        add     r5, r5, r3, ror #25
        eor     lr, r1, lr, ror #25
        str     r1, [sp]
        eor     r9, r5, r9, ror #24
        mov     r1, lr
        add     r7, r7, r9, ror #16
        eor     r0, ip, r0, ror #25
        str     r1, [sp, #64]
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #16]
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #25
        add     r10, r10, r0, ror #20
        eor     r1, r10, r1, ror #16
        add     r5, r5, r3, ror #20
        eor     r9, r5, r9, ror #16
        str     r1, [sp, #16]
        add     ip, ip, r1, ror #24
        ldr     r1, [sp]
        eor     r2, fp, r2, ror #16
        add     r7, r7, r9, ror #24
        add     r1, r1, r2, ror #24
        eor     r3, r7, r3, ror #20
        eor     r0, ip, r0, ror #20
        add     r8, r8, r4, ror #16
        str     r3, [sp]
        str     r0, [sp, #12]
        str     r1, [sp, #20]
        mov     r0, r1
        ldr     r1, [sp, #64]
        eor     r6, r8, r6, ror #25
        add     lr, lr, r6, ror #20
        eor     r0, r0, r1, ror #20
        add     r1, lr, r0, ror #25
        eor     r4, lr, r4, ror #16
        ldr     lr, [sp, #12]
        add     r8, r8, r4, ror #24
        eor     r6, r8, r6, ror #20
        add     fp, fp, lr, ror #25
        ldr     lr, [sp, #16]
        add     r5, r5, r6, ror #25
        add     r10, r10, r3, ror #25
        eor     r3, r5, lr, ror #24
        ldr     lr, [sp, #20]
        str     r3, [sp, #16]
        eor     r9, r1, r9, ror #24
        add     lr, lr, r3, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #20]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        ldr     r3, [sp]
        add     r1, r1, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r1, [sp]
        eor     lr, r7, lr, ror #25
        eor     r9, r1, r9, ror #16
        ldr     r1, [sp, #16]
        str     lr, [sp, #64]
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #20]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #12]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #64]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp, #20]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp]
        str     r2, [sp, #16]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp, #20]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #12]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #16]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        add     r5, r5, r3, ror #25
        eor     r0, ip, r0, ror #20
        eor     r9, r5, r9, ror #24
        str     r0, [sp, #12]
        str     lr, [sp, #20]
        mov     r0, lr
        ldr     lr, [sp, #64]
        add     r7, r7, r9, ror #16
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        eor     r9, r5, r9, ror #16
        add     lr, lr, r0, ror #25
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        str     lr, [sp, #16]
        ldr     lr, [sp, #12]
        ldr     r5, [sp, #16]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        eor     r9, r5, r9, ror #24
        add     lr, lr, r1, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        add     r5, r5, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r5, [sp, #12]
        eor     lr, r7, lr, ror #25
        str     lr, [sp, #20]
        ldr     r5, [sp]
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        str     lr, [sp, #20]
        mov     r0, lr
        ldr     lr, [sp, #64]
        add     r5, r5, r3, ror #25
        eor     r9, r5, r9, ror #24
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        add     r7, r7, r9, ror #16
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     lr, lr, r0, ror #25
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        str     lr, [sp, #16]
        ldr     lr, [sp, #12]
        eor     r9, r5, r9, ror #16
        add     r5, r5, r6, ror #25
        add     fp, fp, lr, ror #25
        str     r5, [sp]
        ldr     r5, [sp, #16]
        ldr     lr, [sp]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        eor     r9, r5, r9, ror #24
        add     lr, lr, r1, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        add     r5, r5, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r5, [sp, #12]
        eor     lr, r7, lr, ror #25
        str     lr, [sp, #20]
        ldr     r5, [sp]
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        add     r5, r5, r3, ror #25
        str     lr, [sp, #20]
        mov     r0, lr
        ldr     lr, [sp, #64]
        eor     r9, r5, r9, ror #24
        add     r7, r7, r9, ror #16
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        add     lr, lr, r0, ror #25
        str     lr, [sp, #16]
        eor     r9, r5, r9, ror #16
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        add     fp, fp, lr, ror #25
        ldr     r5, [sp, #16]
        ldr     lr, [sp]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        eor     r9, r5, r9, ror #24
        add     lr, lr, r1, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        add     r5, r5, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r5, [sp, #12]
        eor     lr, r7, lr, ror #25
        str     lr, [sp, #20]
        ldr     r5, [sp]
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        add     r5, r5, r3, ror #25
        str     lr, [sp, #20]
        mov     r0, lr
        ldr     lr, [sp, #64]
        eor     r9, r5, r9, ror #24
        add     r7, r7, r9, ror #16
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        add     lr, lr, r0, ror #25
        str     lr, [sp, #16]
        eor     r9, r5, r9, ror #16
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        ldr     r5, [sp, #16]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        eor     r9, r5, r9, ror #24
        add     lr, lr, r1, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        add     r5, r5, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r5, [sp, #12]
        eor     lr, r7, lr, ror #25
        str     lr, [sp, #20]
        ldr     r5, [sp]
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        str     lr, [sp, #20]
        add     r5, r5, r3, ror #25
        mov     r0, lr
        ldr     lr, [sp, #64]
        eor     r9, r5, r9, ror #24
        add     r7, r7, r9, ror #16
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        add     lr, lr, r0, ror #25
        str     lr, [sp, #16]
        eor     r9, r5, r9, ror #16
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        ldr     r5, [sp, #16]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        eor     r9, r5, r9, ror #24
        add     lr, lr, r1, ror #16
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r4, fp, r4, ror #24
        eor     r0, ip, r0, ror #25
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        add     r5, r5, r0, ror #20
        add     r7, r7, r4, ror #16
        str     r5, [sp, #12]
        eor     lr, r7, lr, ror #25
        str     lr, [sp, #20]
        ldr     r5, [sp]
        add     fp, fp, lr, ror #20
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        str     lr, [sp, #20]
        add     r5, r5, r3, ror #25
        mov     r0, lr
        ldr     lr, [sp, #64]
        eor     r9, r5, r9, ror #24
        add     r7, r7, r9, ror #16
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        add     lr, lr, r0, ror #25
        str     lr, [sp, #16]
        eor     r9, r5, r9, ror #16
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        ldr     r5, [sp, #16]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        add     lr, lr, r1, ror #16
        eor     r9, r5, r9, ror #24
        eor     r4, fp, r4, ror #24
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        eor     r0, ip, r0, ror #25
        add     r7, r7, r4, ror #16
        eor     lr, r7, lr, ror #25
        add     r5, r5, r0, ror #20
        str     r5, [sp, #12]
        add     fp, fp, lr, ror #20
        str     lr, [sp, #20]
        ldr     r5, [sp]
        ldr     lr, [sp, #12]
        add     r10, r10, r3, ror #25
        eor     r2, r10, r2, ror #24
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        add     r8, r8, r2, ror #16
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        eor     r3, r8, r3, ror #25
        str     lr, [sp, #16]
        add     r10, r10, r3, ror #20
        eor     r4, fp, r4, ror #16
        add     ip, ip, r9, ror #24
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        eor     r2, r10, r2, ror #16
        add     r7, r7, r4, ror #24
        eor     r0, ip, r0, ror #20
        str     r2, [sp]
        add     r8, r8, r2, ror #24
        mov     r2, r0
        eor     r0, r7, lr, ror #20
        ldr     lr, [sp, #12]
        str     r2, [sp, #12]
        add     lr, lr, r6, ror #25
        add     r10, r10, r0, ror #25
        eor     r1, r10, r1, ror #24
        add     fp, fp, r2, ror #25
        eor     r4, lr, r4, ror #24
        mov     r2, lr
        ldr     lr, [sp]
        str     r1, [sp, #20]
        add     ip, ip, r1, ror #16
        ldr     r1, [sp, #16]
        eor     lr, fp, lr, ror #24
        add     r1, r1, lr, ror #16
        str     lr, [sp]
        mov     lr, r1
        ldr     r1, [sp, #12]
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        eor     r1, lr, r1, ror #25
        eor     r6, r8, r6, ror #25
        add     r2, r2, r6, ror #20
        str     r1, [sp, #64]
        eor     r0, ip, r0, ror #25
        add     fp, fp, r1, ror #20
        ldr     r1, [sp, #20]
        str     r2, [sp, #16]
        add     r10, r10, r0, ror #20
        eor     r4, r2, r4, ror #16
        ldr     r2, [sp]
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        add     ip, ip, r1, ror #24
        add     lr, lr, r2, ror #24
        eor     r0, ip, r0, ror #20
        str     r0, [sp, #12]
        str     lr, [sp, #20]
        add     r5, r5, r3, ror #25
        mov     r0, lr
        ldr     lr, [sp, #64]
        eor     r9, r5, r9, ror #24
        add     r7, r7, r9, ror #16
        eor     r0, r0, lr, ror #20
        ldr     lr, [sp, #16]
        eor     r3, r7, r3, ror #25
        add     r8, r8, r4, ror #24
        add     r5, r5, r3, ror #20
        eor     r6, r8, r6, ror #20
        add     lr, lr, r0, ror #25
        str     lr, [sp, #16]
        eor     r9, r5, r9, ror #16
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #25
        str     r5, [sp]
        add     fp, fp, lr, ror #25
        ldr     lr, [sp]
        ldr     r5, [sp, #16]
        eor     r1, lr, r1, ror #24
        ldr     lr, [sp, #20]
        add     r7, r7, r9, ror #24
        add     lr, lr, r1, ror #16
        eor     r9, r5, r9, ror #24
        eor     r4, fp, r4, ror #24
        add     ip, ip, r9, ror #16
        str     lr, [sp, #16]
        eor     r6, lr, r6, ror #25
        ldr     lr, [sp, #12]
        eor     r3, r7, r3, ror #20
        eor     r0, ip, r0, ror #25
        add     r7, r7, r4, ror #16
        eor     lr, r7, lr, ror #25
        add     r5, r5, r0, ror #20
        str     r5, [sp, #12]
        add     fp, fp, lr, ror #20
        ldr     r5, [sp]
        str     lr, [sp, #20]
        ldr     lr, [sp, #12]
        add     r5, r5, r6, ror #20
        eor     r9, lr, r9, ror #16
        ldr     lr, [sp, #16]
        eor     r1, r5, r1, ror #16
        add     lr, lr, r1, ror #24
        str     lr, [sp]
        add     r10, r10, r3, ror #25
        eor     r4, fp, r4, ror #16
        eor     r6, lr, r6, ror #20
        ldr     lr, [sp, #20]
        str     r1, [sp, #16]
        eor     r2, r10, r2, ror #24
        add     r7, r7, r4, ror #24
        add     r8, r8, r2, ror #16
        eor     lr, r7, lr, ror #20
        mov     r1, lr
        eor     r3, r8, r3, ror #25
        ldr     lr, [sp, #12]
        str     r1, [sp, #12]
        add     r10, r10, r3, ror #20
        eor     r2, r10, r2, ror #16
        add     lr, lr, r6, ror #25
        add     ip, ip, r9, ror #24
        add     r8, r8, r2, ror #24
        eor     r4, lr, r4, ror #24
        eor     r0, ip, r0, ror #20
        eor     r3, r8, r3, ror #20
        add     r8, r8, r4, ror #16
        str     r8, [sp, #20]
        add     fp, fp, r0, ror #25
        ldr     r8, [sp]
        eor     r2, fp, r2, ror #24
        add     r8, r8, r2, ror #16
        add     r10, r10, r1, ror #25
        ldr     r1, [sp, #16]
        str     r8, [sp, #16]
        ldr     r8, [sp, #20]
        eor     r1, r10, r1, ror #24
        eor     r6, r8, r6, ror #25
        ldr     r8, [sp, #12]
        add     ip, ip, r1, ror #16
        eor     r8, ip, r8, ror #25
        str     r8, [sp, #64]
        ldr     r8, [sp, #16]
        eor     r0, r8, r0, ror #25
        ldr     r8, [sp, #64]
        add     r5, r5, r3, ror #25
        add     r10, r10, r8, ror #20
        eor     r9, r5, r9, ror #24
        ldr     r8, [sp, #72]
        add     r7, r7, r9, ror #16
        add     lr, lr, r6, ror #20
        eor     r3, r7, r3, ror #25
        eor     r4, lr, r4, ror #16
        add     lr, lr, r8
        ldr     r8, [sp, #76]
        add     r5, r5, r3, ror #20
        eor     r9, r5, r9, ror #16
        add     r5, r5, r8
        ldr     r8, [sp, #24]
        str     r5, [sp, #12]
        add     r8, r8, r10
        str     r8, [sp]
        ldr     r8, [sp, #80]
        add     fp, fp, r0, ror #20
        eor     r1, r10, r1, ror #16
        eor     r2, fp, r2, ror #16
        ldr     r10, [sp, #60]
        add     fp, fp, r8
        ldr     r8, [sp, #20]
        add     r8, r8, r4, ror #24
        add     r4, r10, r4, ror #24
        ldr     r10, [sp, #48]
        str     r4, [sp, #20]
        add     r7, r7, r9, ror #24
        add     r9, r10, r9, ror #24
        ldr     r10, [sp, #52]
        ldr     r4, [sp, #16]
        add     ip, ip, r1, ror #24
        add     r1, r10, r1, ror #24
        ldr     r10, [sp, #56]
        add     r4, r4, r2, ror #24
        add     r2, r10, r2, ror #24
        ldr     r10, [sp, #28]
        eor     r0, r4, r0, ror #20
        add     r10, r10, r0, ror #25
        ldr     r0, [sp, #36]
        add     r4, r4, r0
        ldr     r0, [sp, #84]
        eor     r6, r8, r6, ror #20
        add     r6, r0, r6, ror #25
        ldr     r0, [sp, #40]
        ldr     r5, [sp, #4]
        add     r8, r8, r0
        ldr     r0, [sp, #44]
        eor     r3, r7, r3, ror #20
        add     r7, r7, r0
        ldr     r0, [sp, #64]
        add     r3, r5, r3, ror #25
        ldr     r5, [sp, #8]
        str     r3, [sp, #4]
        eor     r0, ip, r0, ror #20
        add     r0, r5, r0, ror #25
        ldr     r5, [sp, #32]
        ldr     r3, [sp, #68]
        add     ip, ip, r5
        ldr     r5, [sp, #12]
        strb    r5, [r3, #4]
        ldr     r5, [sp]
        strb    r5, [r3, #8]
        lsr     r5, lr, #8
        strb    r5, [r3, #1]
        lsr     r5, lr, #16
        strb    r5, [r3, #2]
        ldr     r5, [sp, #12]
        strb    lr, [r3]
        lsr     lr, lr, #24
        strb    lr, [r3, #3]
        lsr     lr, r5, #8
        strb    lr, [r3, #5]
        lsr     lr, r5, #16
        lsrs    r5, r5, #24
        strb    r5, [r3, #7]
        ldr     r5, [sp]
        strb    fp, [r3, #12]
        lsrs    r5, r5, #8
        strb    r5, [r3, #9]
        ldr     r5, [sp]
        strb    lr, [r3, #6]
        lsrs    r5, r5, #16
        strb    r5, [r3, #10]
        ldr     r5, [sp]
        strb    r10, [r3, #16]
        lsrs    r5, r5, #24
        strb    r5, [r3, #11]
        lsr     r5, fp, #8
        strb    r5, [r3, #13]
        lsr     r5, fp, #16
        lsr     fp, fp, #24
        strb    fp, [r3, #15]
        strb    r6, [r3, #20]
        strb    r5, [r3, #14]
        ldr     r5, [sp, #4]
        strb    r5, [r3, #24]
        lsr     r5, r10, #8
        strb    r5, [r3, #17]
        lsr     r5, r10, #16
        strb    r5, [r3, #18]
        lsrs    r5, r6, #8
        strb    r5, [r3, #21]
        lsrs    r5, r6, #16
        strb    r5, [r3, #22]
        ldr     r5, [sp, #4]
        strb    r0, [r3, #28]
        lsrs    r5, r5, #8
        strb    r5, [r3, #25]
        ldr     r5, [sp, #4]
        strb    ip, [r3, #32]
        lsr     r10, r10, #24
        lsrs    r6, r6, #24
        lsrs    r5, r5, #16
        mov     lr, r3
        strb    r4, [r3, #36]
        strb    r8, [r3, #40]
        strb    r7, [r3, #44]
        strb    r9, [r3, #48]
        strb    r10, [r3, #19]
        strb    r6, [r3, #23]
        strb    r5, [r3, #26]
        ldr     r3, [sp, #4]
        lsrs    r3, r3, #24
        strb    r3, [lr, #27]
        lsrs    r3, r0, #8
        strb    r3, [lr, #29]
        lsrs    r3, r0, #16
        strb    r3, [lr, #30]
        lsr     r3, ip, #8
        strb    r3, [lr, #33]
        lsr     r3, ip, #16
        strb    r3, [lr, #34]
        lsrs    r3, r4, #8
        strb    r3, [lr, #37]
        lsrs    r3, r4, #16
        strb    r3, [lr, #38]
        lsr     r3, r8, #8
        strb    r3, [lr, #41]
        lsr     r3, r8, #16
        strb    r3, [lr, #42]
        lsrs    r0, r0, #24
        lsrs    r3, r7, #8
        lsr     ip, ip, #24
        lsrs    r4, r4, #24
        lsr     r8, r8, #24
        strb    r0, [lr, #31]
        strb    r4, [lr, #39]
        strb    ip, [lr, #35]
        strb    r8, [lr, #43]
        strb    r3, [lr, #45]
        lsrs    r3, r7, #16
        strb    r3, [lr, #46]
        lsr     r3, r9, #8
        strb    r3, [lr, #49]
        lsr     r3, r9, #16
        strb    r3, [lr, #50]
        lsrs    r3, r1, #8
        strb    r3, [lr, #53]
        lsrs    r3, r1, #16
        ldr     r0, [sp, #20]
        strb    r3, [lr, #54]
        lsrs    r3, r2, #8
        strb    r1, [lr, #52]
        strb    r3, [lr, #57]
        lsrs    r1, r1, #24
        lsrs    r3, r2, #16
        lsrs    r4, r0, #24
        lsrs    r7, r7, #24
        strb    r2, [lr, #56]
        strb    r0, [lr, #60]
        lsr     r9, r9, #24
        strb    r1, [lr, #55]
        lsrs    r2, r2, #24
        lsrs    r1, r0, #8
        strb    r3, [lr, #58]
        lsrs    r3, r0, #16
        movs    r0, #0
        strb    r7, [lr, #47]
        strb    r9, [lr, #51]
        strb    r2, [lr, #59]
        strb    r1, [lr, #61]
        strb    r3, [lr, #62]
        strb    r4, [lr, #63]
        add     sp, sp, #92
        pop     {r4, r5, r6, r7, r8, r9, r10, fp, pc}