#!/bin/bash

#pegando todos os scripts
ls >  arquivos
grep '.sh' arquivos  > scripts
grep '.in' arquivos > entradas
grep '.out' arquivos > saidas


