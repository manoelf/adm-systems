#!/bin/bash

#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Sexta atividade. Trabalhando com redes                #
#=======================================================#


#Facebook IP
pacotes=10
ip="69.171.230.68"
info=$(mktemp)
out=$(mktemp)
saida=$(mktemp)
result=$(mktemp)



#EXTRA
#Opcoes de usar um ip diferente do default
echo "O IP trabalhado sera $ip (Facebook). Deseja usar um IP diferente? (sim/nao)"
read resp

if [ "$resp" == "sim" ]; then
    echo "digite um ip valido, caso contrario o programa sera quebrado :P" 
    read ip;
fi

#Opcao de envar uma quantidade de pacotes diferente de 10
echo "Deseja enviar uma quantidade diferente de 10 pacotes? (sim/nao)"
read resp


if [ "$resp" == "sim" ]; then
    echo "Digite a nova quantidade"
    read pacotes
fi

echo "Processando . . ."
echo

#Enviando os pacotes e armazenando as informacoes em arquivos
ping -c $pacotes -c $pacotes $ip > $info
ping -s 64 -c $pacotes $ip > $out

#Pegando apenas as linhas que contem a informacao do tempo
sed -i '/64/!d' $info
cut -d "=" -f4 $info | sort -rn > $saida 

sed -i '/72/!d' $out
cut -d "=" -f4 $out | sort -rn > $result

#Pegando a mediana
meio=$(($pacotes/2))
mediana=$(sed -n $meio' p;' $saida)
mediana2=$(sed -n $meio' p;' $result)


media=0
media2=0
range=0
#Caso seja solicitado uma quantidae inferior a 3 pacotes
if [ $pacotes -gt 3 ]; then
    range=$((pacotes-3))
fi

#Pegando apenas o campo referente ao tempo dos tres ultmos e maiores tempos
#Somando a uma varivale para ser calculado a media

for i in $(seq $range $pacotes);do
    num=$(sed -n $i' p;' $saida | cut -d " " -f1)
    num2=$(sed -n $i' p;' $result | cut -d " " -f1)
    let media=$media+$num
    let media2=$media2+$num2
done
    
echo "Mediana do tempo eh" $mediana
echo "Media dos 3 maiores valores eh $(($media/3)) ms"

echo
echo "Mediana do tempo eh" $mediana2
echo "Mediana dos 3 maiores tempos eh $(($media2/3)) ms"

#Removendo os arquivos temporarios
rm $info
rm $out
rm $saida
rm $result

#1
#PING X (Y) Z(W) bytes of data.
#PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
# X: Endereco ip (caso seja dado o nome, sera o nome do site)
# Y: Endereco ip
# Z: Tamanho do pacote enviado

#2
#A bytes from B (C): icmp_seq=D ttl=E time=F ms
#64 bytes from 8.8.8.8: icmp_seq=1 ttl=45 time=107 ms
# A:
# B: Caso passe o numero ip sera o i, caso passe o nome sera o nome do site 
# C: Nome do site, caso seja pesquisado por nome.

#3
#ping -c 2 google.com
#PING google.com (172.217.29.46) 56(84) bytes of data.
#64 bytes from google.com (172.217.29.46): icmp_seq=1 ttl=55 time=133 ms
# Serao diferentes, um sera o endereco IP e o outro o nom.

