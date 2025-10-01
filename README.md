# Cryptographic Optimizations: ChaCha20, Poly1305, and ECDH

This project focuses on optimizing three widely used cryptographic primitives — **ChaCha20**, **Poly1305**, and **Elliptic Curve Diffie-Hellman (ECDH)** — for efficient execution on the **ARM Cortex-M4 microcontroller**.  

The motivation behind this work is to improve performance while maintaining correctness and security properties such as constant-time execution. Cryptographic primitives are often performance bottlenecks in resource-constrained environments (e.g., embedded systems, IoT), making such optimizations highly relevant.

---

## 📌 Project Goals

- Start from public C reference implementations of:
  - [ChaCha20](https://cr.yp.to/papers.html#chacha)  
  - [Poly1305](https://cr.yp.to/papers.html#poly1305)  
  - ECDH key exchange on Curve25519 in Edwards form
- Re-engineer the implementations to run **substantially faster** on the ARM Cortex-M4.
- Ensure that the optimized code:
  - Has **no secret-dependent branches** or memory accesses (constant-time execution).  
  - Passes all regression tests (functional correctness preserved).  
  - Substantially outperforms the reference implementations.  

---

## ⚙️ Implementations & Optimizations

### 🔹 ChaCha20
- Optimized **rotate function** using single assembly instruction.  
- Removed **function calls** to eliminate push/pop overhead.  
- **Loop unrolling** reduced cycles further.  
- **Result:** 27,491 cycles (≈15% reduction).

### 🔹 Poly1305
- Changed internal representation from **radix-8 → radix-26**.  
- Designed an efficient **8-bit to 26-bit shifter translation** for constant-time performance.  
- Optimized **modular multiplication** for the new radix.  
- **Result:** 27,091 cycles (≈69% reduction).

### 🔹 ECDH
- Eliminated secret-dependent branching to avoid timing leaks.  
- Implemented **fixed-window scalar multiplication** (ω = 4) with precomputation table.  
- Optimized field arithmetic using **radix-26** representation.  
- Handled intermediate multiplication overflow with modular reduction.  
- **Result:** 15.6M cycles (≈66% reduction).

---

## 📊 Results Summary

| Algorithm | Initial Cycles | Borderline Target | Optimized Cycles | Reduction |
|-----------|---------------|-------------------|------------------|-----------|
| **ChaCha20** | 32,192 | 30,000 | 27,491 | ~15% |
| **Poly1305** | 87,482 | 80,000 | 27,091 | ~69% |
| **ECDH** | 45.6M / 42.5M | 35M / 32M | 15.6M / 14.6M | ~66% |

---

## 🔧 Usage
This project was developed as a research/academic exercise.  
To reproduce:
1. Connect the ARM Cortex-M4 microcontroller UART by USB
2. Run ./run.sh [test|speed] inside the primitive directory
3. Reset the microcontroller using the reset button and get the results

---

More details on the final implementation in "Final_Report.pdf".

Usefull links:
- Instruction timings: https://developer.arm.com/documentation/ddi0337/h/programmers-model/instruction-set-summary/cortex-m3-instructions?lang=en
- Explorer Compiler: https://godbolt.org/
