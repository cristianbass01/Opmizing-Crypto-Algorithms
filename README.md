# Optimizing Cryptographic Algorithms
This project focuses on optimizing 3 primitives implemented in C:
- ChaCha20
- Poly1305
- ECDH
for the ARM Cortex-M4 microcontroller.

More details on "Project_Description.pdf".

## How to test and time

1. Connect the ARM Cortex-M4 microcontroller UART by USB
2. Run ./run.sh [test|speed] inside the primitive directory
3. Reset the microcontroller using the reset button and get the results


## Final results:

| Algorithm | Initial Implementation (cycles) | Our Implementation (cycles) |
|-----------|---------------------------------|-----------------------------|
| ChaCha20  | 32,192                          | 27,491                      |
| Poly1305  | 87,482                          | 27,091                      |
| ECDH      | (45,611,933, 42,491,583)        | (15,595,424, 14,634,796)    |

More details on the final implementation in "Final_Report.pdf"