#!/bin/bash

# wget baixa o arquivo do endereco especificado
# -O remomeia o arquivo para o novo nome especificadp
wget http://ita.ee.lbl.gov/traces/calgary_access_log.gz -O acessfile.gz

# descompacta o arqiovo .gz
gunzip acessfile.gz

# remove todas as linhas que nao tenham o padrao especificado
# -i in-plase, altera diretamente no arquivo
# !d remove as linas
sed -i '/ - - /!d' acessfile

# variaveis para contabilizar os arquivos remote e local
remotes=0;
locals=0;

# iterando sobre as linhas do arquivo
while read line
do
	# verifica se a linha contem a seguinte expressao e incrementa a quatidae de acessos
        if [[ $line == *"remote"* ]]
        then
                let remotes=$remotes+1;
        elif [[ $line == *"local"* ]]
        then
                let locals=$locals+1;
        fi
done < acessfile

echo "Total de requisicoes locais $locals"
echo "Total de requisicoes remotas $remotes"





