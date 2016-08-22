#!/bin/bash
#=======================================================#
# Aluno: Jose Manoel Ferreira                           #
# Prof: Matheus G. Rego                                 #
#                                                       #
# Primeira atividade com introducao a programacao shell #
# para pratiaca da sintaxe e comandos basicos.          #
#                                                       #
#=======================================================#

echo -e "Fazendo o download do arquivo...\n"

# wget baixa o arquivo do endereco especificado
# -O remomeia o arquivo para o novo nome especificado
wget http://ita.ee.lbl.gov/traces/calgary_access_log.gz -O acessfile.gz

echo -e "Descompactando o arquivo...\n"

# descompacta o arqiovo .gz
gunzip acessfile.gz

# remove todas as linhas que nao tenham o padrao especificado
# -i in-place, altera diretamente no arquivo
# !d remove as linas
sed -i '/ - - /!d' acessfile

echo -e "Computando os dados...\n"

# variaveis para contabilizar os arquivos remote e local
remotes=0;
locals=0;
horas_remotes=0
horas_locals=0

# ISF (internal field separator) recebendo um novo separador
IFS=":"

# iterando sobre as linhas do arquivo
while read line
do
	# verifica se a linha contem a seguinte expressao e incrementa a quatidae de acessos
        if [[ $line == *"remote"* ]]
        then
                #atribuicao de valores juntamente com operacao  aritimetica
                let remotes=$remotes+1;
		set -- $line
                # eh usado o 10#$2 para informar que o valor de $2 sera decimal. base 10
                # caso nao seja feito isso lancara um erro por uso de octais
		let horas_remotes=$horas_remotes+10#$2;
        elif [[ $line == *"local"* ]]
        then
                let locals=$locals+1;
                let horas_locals=$horas_locals+10#$2;

        fi
done < acessfile

echo "Total de requisicoes locais: $locals"
echo "Total de requisicoes remotas: $remotes"
echo "Total de horas remotes: $horas_remotes"
echo "Total de horas locals: $horas_locals"
echo "Media de horas em que as requisicoes remotas sao feitas: $(($horas_remotes/$remotes))"
echo "Media de horas em que as requisicoes locais sao feiras: $(($horas_locals/$locals))"


if [[ $locals -gt $remotes ]];
then
        echo "Os arquivos mais acessados sao os locals"
elif [[ $remotes -gt $locals ]];
then 
        echo "Os arquivos mais acessados sao os remotes"
else
        echo "Os arquivos tem a mesma quantidade de acessos"
fi

