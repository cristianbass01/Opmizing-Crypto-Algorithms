#!/bin/bash

# Usage: ./run.sh [test|speed] inside the chacha20 directory

make clean

# Test the ChaCha20 implementation
make

file_to_run=""

# If the first argument is test, run the test
if [ "$1" == "test" ]; then
    file_to_run="poly1305test.bin"
elif [ "$1" == "speed" ]; then
    file_to_run="poly1305speed.bin"
else
    echo "Usage: $0 [test|speed] inside the poly1305 directory"
    exit 1
fi

# Send to the Cortex M4
st-flash write $file_to_run 0x08000000

# Get the output
./../host_unidirectional/host_unidirectional.py
