#!/bin/bash
g++ -std=c++23 -I$HOME/atcoder/ac-library main.cpp && oj test -c ./a.out -d ./tests -S
