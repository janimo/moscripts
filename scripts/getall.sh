#!/bin/bash

#Get the original PDF files provided by moficial.ro which is an unofficial archive of
#all texts.

for an in {1989..2012};do
    wget -c -r -l 1 -A pdf www.moficial.ro/an/$an
done
