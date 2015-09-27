#!/bin/bash
ZIM=$(ls -1 /zim/*.zim | tail -1 | cut -d'.' -f1)
./gozimindex -path=${ZIM}.zim -index=${ZIM}.idx 
