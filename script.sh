#!/usr/bin/env bash

jflex -d . ScannerImplementation_A1.jflex
javac Yylex.java
java Yylex test > output.txt
