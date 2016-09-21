#!/bin/bash
if [[ "nasm simSum.asm -o simSum.com" ]]; then
  open -a DOSBox;
fi
