#!/bin/sh

bins=("duer" "ww")

for item in "${bins[@]}"; do
  curl -O "https://server.numericaltools.com/bins/$item" &
done

wait

for item in "${bins[@]}"; do
  chmod +x "$item"
done
