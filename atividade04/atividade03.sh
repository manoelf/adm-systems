#!/bin/bash

#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Terceira  atividade praticas em shell  scripts        #
# Uso de ferramentas para analise de chamadas do sistema#
#                                                       #
#=======================================================#

# Armazenando a saida so strace
strace -To file $*

#Ordenando por o tempo e salvando em um arquivo
sort -n -t "<" -k 2 file > sorted
echo "Chamadas:"

#Iimprimindo os tres ultimos que serao os com maiores tempos
tail -n 3 sorted
echo

#Contando a quantidade de linhas
total=$(wc -l file | cut -d ' ' -f 1)
echo "Syscall: $total"
echo

echo "Syscall mais chamada:"
#Pegando apenas o nome da chamada, agrupando os repetidos, ordenando e pegando o ultimo elemento
cut -d '(' -f 1 file | sort | uniq -c | sort -k1 -n | tail -n 1
echo 

echo "Syscall menos chamada:"
cut -d '(' -f 1 file | sort | uniq -c | sort -k1 -n | head -n 1
echo

#Mostrando a syscall com o maior numero de erros (retornos negativos)
echo "Syscall com mais erros:"
grep '= -' file | sort | cut -d '(' -f 1 | uniq -c | head -n 1
echo

#agrupados e contabilizados as chamadas com erros, e depois ordenadas
echo "Todas syscall com erros:"
grep '= -' file | sort | cut -d '(' -f 1 | uniq -c

#removendo arquivos usado 
rm file
rm sorted
