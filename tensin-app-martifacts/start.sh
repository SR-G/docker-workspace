#!/bin/bash

export CLASSPATH=$(ls -1 libs/*.jar|tr "\n" ":")
java -Duser.home=/datas/ com.martiansoftware.martifacts.web.App
