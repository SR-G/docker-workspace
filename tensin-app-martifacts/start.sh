#!/bin/bash

export CLASSPATH=$(ls -1 libs/*.jar|tr "\n" ":")
java com.martiansoftware.martifact.web.App
