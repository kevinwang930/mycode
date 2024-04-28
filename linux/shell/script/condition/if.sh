#!/bin/zsh

echo -n "Enter a number: "
read VAR

if [ $VAR -gt 10 ]; then
  echo "The variable is greater than 10."
fi

if [ $VAR = 10 ]; then
  echo "var = 10"
fi
