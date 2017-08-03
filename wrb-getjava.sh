#!/bin/bash

#Download do Java oficial da Oracle - para instalação no Debian/Ubuntu
#Welington Braga - www.welrbraga.eti.br

#Lista todos os releases de JRE disponíveis para download
function list_releases() {
    echo "Os seguintes releases do JRE estão disponíveis para download"
    awk -F\| '$1 !~ /^#|^$/ { print $1 }' "${CACHEDIR}/${URLFILE}"
}

#Le o arquivo de URLs disponíveis e verifica a URL da JRE desejada
#Recebe dois parâmetros o "formato do arquivo" e a versão desejada do JRE
function set_release() {
    read FORMATFILE LASTJRE <<< `awk -F\| 'BEGIN { FORMATO="" } $1 !~ /^#|^$/ { if ( FORMATO == "" ) { FORMATO=$1 ; LASTJRE=$3 }; } END { print FORMATO " " LASTJRE }' "${CACHEDIR}/${URLFILE}"`
    VALIDFORMAT="$1"
    JRERELEASE="$2"

    if [ ! "${FORMATFILE}" == "${VALIDFORMAT}" ]
    then
        echo
        echo "ERRO: A Versão do arquivo de URLs disponível não é compatível com a versão do script que você está usando."
        echo "Faça o download da nova versão do script a partir do Github em https://github.com/welrbraga/get-java"
        echo
        echo "Abortando!"
        exit
    else
        echo "Arquivo URLs versão ${FORMATFILE} aceito"
        echo
        read VERSION URL64 URL32 <<< $(awk -F\| '$1=="'${JRERELEASE}'" { print $1 " " $2 " " $3 }' "${CACHEDIR}/${URLFILE}")
    fi

    if [ "${VERSION}" == "" ]
    then
        echo "ERRO: O Release ${JRERELEASE} do JRE não está disponível.
Certifique-se de informar uma versão válida e que esteja disponível para download"
        echo
        list_releases
        echo
        echo "Abortando!"
        exit
    fi
}

#Verifica qual é  arquitetura do sistema para baixar a JRE adequada a ela
function set_arch() {
    ARCH=`uname -m`
    if [ "${ARCH}" == "x86_64" ]
    then
        echo -n "* Selecionada versão 64bits"
        URL=${URL64}
        ARCHPLUGIN="amd64"
        # desde  a versao 12.04 o ubuntu usa o arquivo libnpjp2.so como plugin
        FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
        echo ""
    else
        echo "* Selecionada versão 32bits"
        URL=${URL32}
        ARCHPLUGIN="i386"
        FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
    fi
}

#Faz o download e descompacta o pacote com a JRE selecionada
function get_java() {
    if [ ! -f "${CACHEDIR}/${DOWNLOADEDJAVA}" ]
    then
        echo "* Obtendo o Java ${JRERELEASE} a partir do site oficial. Aguarde..."
        wget -q "${URL}" -O "${CACHEDIR}/${DOWNLOADEDJAVA}"
    else
        echo "AVISO: Usando download já existente em ${CACHEDIR}/${DOWNLOADEDJAVA}."
        echo "Caso seja necessario baixar outro arquivo exclua este arquivo manualmente"
        echo "com o comando abaixo:"
        echo
        echo "  $ sudo rm ${CACHEDIR}/${DOWNLOADEDJAVA}"
        echo
    fi

    echo "* Descompactando o pacote Java"
    if [ "${VERSION:0:2}" == "6u" ]
    then
        chmod +x "${CACHEDIR}/${DOWNLOADEDJAVA}"
        "${CACHEDIR}/${DOWNLOADEDJAVA}"
    else
        tar xzf "${CACHEDIR}/${DOWNLOADEDJAVA}"
    fi
}

#Configura a JRE descompactada como default do sistema
function make_alternatives() {

    echo "* Configurando alternativas do sistema padrão"
    if [ "${VERSION:0:2}" == "6u" ]
    then
        export `head -n 161 ${CACHEDIR}/${DOWNLOADEDJAVA}|grep "javahome="`
    else
        javahome=$(dirname `tar tf ${CACHEDIR}/${DOWNLOADEDJAVA} --wildcards */release`)
        export javahome
    fi

    PRIORITY=$1

    PLUGIN="${PATHJAVA}/${javahome}/${FILEPLUGIN}"

    NAME="mozilla-javaplugin.so"
    LINK="/usr/lib/mozilla/plugins/libjavaplugin.so"

    update-alternatives --install ${LINK} ${NAME} ${PLUGIN} ${PRIORITY}
    update-alternatives --set ${NAME} ${PLUGIN}

    NAME="firefox-javaplugin.so"
    LINK="/usr/lib/firefox-addons/plugins/libjavaplugin.so"

    update-alternatives --install ${LINK} ${NAME} ${PLUGIN} ${PRIORITY}
    update-alternatives --set ${NAME} ${PLUGIN}

    NAME="xulrunner-javaplugin.so"
    LINK="/usr/lib/xulrunner/plugins/libjavaplugin.so"

    update-alternatives --install ${LINK} ${NAME} ${PLUGIN} ${PRIORITY}
    update-alternatives --set ${NAME} ${PLUGIN}

    #Faz um loop sobre todo o conteúdo do diretório "bin" facilitando a
    #criação dos alternatives
    for file in `ls "${PATHJAVA}/${javahome}/bin"`;
    do
	echo "  -" $file

	NAME=${file}
	LINK=/usr/bin/${file}
	TARGET=${PATHJAVA}/${javahome}/bin/${file}

	update-alternatives --install ${LINK} ${NAME} ${TARGET} ${PRIORITY}
	update-alternatives --set ${NAME} ${TARGET}

    done
}

#Atualiza as páginas de manual das ferramentas
function update_manual() {
  echo "* Atualizando páginas de manual"
  ln -fs ${PATHJAVA}/${javahome}/man/man1 /usr/local/man/
  ln -fs ${PATHJAVA}/${javahome}/man/ja /usr/local/man/
  mandb -q

}


function show_help() {
cat <<EOF
get-Java - Instala uma Oracle JRE no seu sistema

Uso:
 $0 [flag]

As flags e parâmetros disponíveis para uso são:

  -h - Mostra este texto explicativo de ajuda

  -i - Instala uma das versões disponíveis informada pelo usuário (use a
       flag '-l' para listar as versões disponíveis)

  -l - Lista todas as versões disponíveis e suportadas pelo script

  -n - Instala a última versão do JRE disponível e suportada pelo script

EOF

}

#Faz o download do arquivo com a lista de URLs válidas do JRE
#Esta função deve ser invocada antes de qualquer outra que requeira
#Obterm versões de JRE
function get_table() {

    #Cria o diretório de cache caso não exista
    if [ ! -d "${CACHEDIR}" ]
    then
        mkdir -p "${CACHEDIR}"
    fi

    echo "* Baixando novo arquivo de URLs disponíveis..."
    wget -q "${URLCACHE}" -O "${CACHEDIR}/${URLFILE}"

}

###############################################################################
# INICIO DO SCRIPT
###############################################################################

URLCACHE="https://raw.githubusercontent.com/welrbraga/get-java/master/getjava.urls"
CACHEDIR="/var/cache/getjava"
URLFILE="getjava.urls"

#So prossegue se estiver com privilégios administrativos (root)
if [ "$UID" != "0" ]
then
    echo "ERRO: Você precisa ser administrador para conseguir instalar a máquina Java em seu sistema"
    echo "Tente novamente com: sudo $0"
    exit
fi

#Trata as opções de trabalho do script
# -i - instala a versão especificada
# -n - instala a última versão
# -l - Lista todas as versões disponíveis para download e isntalação
while getopts ":hi:nl" OPT "$@"
do
  case $OPT in
    "h") #Chama a ajuda e sai
      show_help
      echo
      exit 1
      ;;
    "i") #Instalação do JRE com a versão especificada - se existir na lista
      get_table
      JRE=${OPTARG}
      ;;
    "n") #Instalação da última versão da JRE disponível na tabela de urls
      get_table
      LASTJRE=$(list_releases|tail -n 1)
      JRE=${LASTJRE}
      ;;
    "l")
      echo "Os seguintes releases da Oracle JRE estão disponíveis para download e instalação"
      echo
      get_table
      list_releases
      echo
      exit 2
      ;;
    "?")
      echo
      echo "A opção -$OPTARG não é válida."
      echo
      show_help
      exit 3
      ;;
    ":")
      echo
      echo "A opção -$OPTARG requer que seja informada a versão da JRE a ser instalada. Use a flag '-l' para listar todas as versões do JRE disponíveis"
      echo
      show_help
      exit 4
      ;;
  esac
done

#Caso anenhum parâmetro seja informado exibe a ajuda e sai
if [ "${OPTIND}" == "1" ]
then
  echo
  show_help
  echo
  exit 5
fi

set_release "B" ${JRE}

set_arch

echo "* Configurando o diretório onde a nova versão do Java será armazenada"
PATHJAVA="/opt/java-${ARCHPLUGIN}"
[ -d "${PATHJAVA}" ] || mkdir -p "${PATHJAVA}"
cd "${PATHJAVA}"


#Arquivo binário baixado do site do Java
if [ "${VERSION:0:2}" == "6u" ]
then
    DOWNLOADEDJAVA="java-${ARCHPLUGIN}-${VERSION}.bin"
else
    DOWNLOADEDJAVA="java-${ARCHPLUGIN}-${VERSION}.tar.gz"
fi
#

get_java

chown -R root:root "${PATHJAVA}"

make_alternatives 1000

update_manual

echo "Done"
