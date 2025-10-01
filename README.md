# Cryptographic Optimizations: ChaCha20, Poly1305, and ECDH

This project explores performance optimizations of three widely used cryptographic algorithms: **ChaCha20**, **Poly1305**, and **Elliptic Curve Diffie-Hellman (ECDH)**.  
Our goal was to reduce execution cycles while ensuring correctness and constant-time execution to prevent side-channel attacks.

---

## 📌 Project Overview

We implemented and optimized:
- **ChaCha20** (stream cipher)  
- **Poly1305** (message authentication code)  
- **ECDH** on Ed25519 curves (key exchange protocol)

The optimizations were focused on:
- **Assembly-level improvements**  
- **Radix transformation (from 8 to 26)**  
- **Constant-time implementations to mitigate timing leaks**  

More details on "Project_Description.pdf".

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
