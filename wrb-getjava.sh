#!/bin/bash

#Download do Java oficial da Oracle - para instalação no Debian/Ubuntu
#Welington Braga - www.welrbraga.eti.br

#WBRAGA - 2011-12-30
#WBRAGA - 2012-04-17 - Não executa se o usuário não for o root

#URLS obtidas em http://www.java.com/pt_BR/download/manual.jsp

#DEBUG - DAR UM JEITO DE REMOVER ISSO
LASTJRE="7u75"


#Le o arquivo de URLs disponíveis e verifica a URL da JRE desejada
function set_release() {
	URLFILE="getjava.urls"
	FILEVERSION=`grep -vE '^$|^#' "${URLFILE}" |head -n1`
	ACCEPTVERSION="$1"
	JRERELEASE="$2"

	if [ ! "${FILEVERSION}" == "${ACCEPTVERSION}" ]
	then
		echo "Versão do arquivo de URLs invalida"
		echo "Abortando!"
		exit
	else
		echo "Arquivo URLs versão ${FILEVERSION} aceito"
		VERSION=`grep "^${JRERELEASE}" "${URLFILE}"|cut -d '|' -f 1`
		URL64=`grep "^${JRERELEASE}" "${URLFILE}"|cut -d '|' -f 2`
		URL32=`grep "^${JRERELEASE}" "${URLFILE}"|cut -d '|' -f 3`
	fi

}

#Verifica qual é  arquitetura do sistema para baixar a JRE adequada a ela
function set_arch() {
ARCH=`uname -m`
if [ "${ARCH}" == "x86_64" ]; then
    echo -n "Selecionada versão 64bits"
    URL=${URL64}
    ARCHPLUGIN="amd64"
# desde  a versao 12.04 o ubuntu usa o arquivo libnpjp2.so como plugin
    FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
    echo ""
else
    echo "Selecionada versão 32bits"
    URL=${URL32}
    ARCHPLUGIN="i386"
    FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
fi
}

#Faz o download e descompacta o pacote com a JRE selecionada
function getjava() {
    if [ ! -f "${DOWNLOADEDJAVA}" ]; then
        echo "Obtendo o Java a partir do site oficial"
		wget "${URL}" -O ${DOWNLOADEDJAVA}
    else
        echo "Usando download já existente em ${PATHJAVA}/${DOWNLOADEDJAVA}"
        echo "Caso seja necessario baixar outro arquivo exclua este arquivo manualmente"
	echo "com o comando abaixo:"
	echo
	echo "  $ sudo rm ${PATHJAVA}/${DOWNLOADEDJAVA}"
        echo
    fi

    echo "Descompactando o Java"
    if [ "${VERSION:0:2}" == "6u" ]; then
		chmod +x ${DOWNLOADEDJAVA}
        ./${DOWNLOADEDJAVA}
    else
        tar xzf ${DOWNLOADEDJAVA}
    fi
}

#Configura a JRE descompactada como default do sistema
function makealternatives() {

    echo "Configurando nova versão como alternativa padrão"
    if [ "${VERSION:0:2}" == "6u" ]; then
        export `head -n 161 ${DOWNLOADEDJAVA}|grep "javahome="`
    else
        javahome=$(dirname `tar tf ${DOWNLOADEDJAVA}|grep release`)
        export javahome
    fi
    
    PLUGIN="${PATHJAVA}/${javahome}/${FILEPLUGIN}"

    update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so mozilla-javaplugin.so ${PLUGIN} 1000
	update-alternatives --set mozilla-javaplugin.so ${PLUGIN}
 
    update-alternatives --install /usr/lib/firefox-addons/plugins/libjavaplugin.so firefox-javaplugin.so ${PLUGIN} 1000
    update-alternatives --set firefox-javaplugin.so ${PLUGIN}

    update-alternatives --install /usr/lib/xulrunner/plugins/libjavaplugin.so xulrunner-javaplugin.so ${PLUGIN} 1000
    update-alternatives --set xulrunner-javaplugin.so ${PLUGIN}

    #
    #Useless... we are useless... but we are here
    update-alternatives --install /usr/bin/java java ${PATHJAVA}/${javahome}/bin/java 1000
    update-alternatives --set java ${PATHJAVA}/${javahome}/bin/java

    update-alternatives --install /usr/bin/javaws javaws ${PATHJAVA}/${javahome}/bin/javaws 1000
    update-alternatives --set javaws ${PATHJAVA}/${javahome}/bin/javaws

    update-alternatives --install /usr/bin/keytool keytool ${PATHJAVA}/${javahome}/bin/keytool 1000
    update-alternatives --set keytool ${PATHJAVA}/${javahome}/bin/keytool

    update-alternatives --install /usr/bin/orbd orbd ${PATHJAVA}/${javahome}/bin/orbd 1000
    update-alternatives --set orbd ${PATHJAVA}/${javahome}/bin/orbd

    update-alternatives --install /usr/bin/pack200 pack200 ${PATHJAVA}/${javahome}/bin/pack200 1000
    update-alternatives --set pack200 ${PATHJAVA}/${javahome}/bin/pack200

    update-alternatives --install /usr/bin/policytool policytool ${PATHJAVA}/${javahome}/bin/policytool 1000
    update-alternatives --set policytool ${PATHJAVA}/${javahome}/bin/policytool

    update-alternatives --install /usr/bin/rmid rmid ${PATHJAVA}/${javahome}/bin/rmid 1000
    update-alternatives --set rmid ${PATHJAVA}/${javahome}/bin/rmid

    update-alternatives --install /usr/bin/rmiregistry rmiregistry ${PATHJAVA}/${javahome}/bin/rmiregistry 1000
    update-alternatives --set rmiregistry ${PATHJAVA}/${javahome}/bin/rmiregistry

    update-alternatives --install /usr/bin/servertool servertool ${PATHJAVA}/${javahome}/bin/servertool 1000
    update-alternatives --set servertool ${PATHJAVA}/${javahome}/bin/servertool

    update-alternatives --install /usr/bin/tnameserv tnameserv ${PATHJAVA}/${javahome}/bin/tnameserv 1000
    update-alternatives --set tnameserv ${PATHJAVA}/${javahome}/bin/tnameserv

    update-alternatives --install /usr/bin/unpack200 unpack200 ${PATHJAVA}/${javahome}/bin/unpack200 1000
    update-alternatives --set unpack200 ${PATHJAVA}/${javahome}/bin/unpack200

    update-alternatives --install /usr/bin/jexec jexec ${PATHJAVA}/${javahome}/lib/jexec 1000
    update-alternatives --set jexec ${PATHJAVA}/${javahome}/lib/jexec

}

###############################################################################
# INICIO DO SCRIPT
###############################################################################


if [ "$UID" != "0" ]; then
	echo "Você precisa ser administrador para conseguir instalar a máquina Java em seu sistema"
	echo "Tente novamente com: sudo $0"
	exit
fi

#Baixa a última versao da JRE ou a versão solicitada
if [ "$1" == "" ]; then
	JRE=${LASTJRE}
else
	JRE=$1
fi

set_release "A|A|A" ${JRE}

echo $URL64
echo $URL32
echo $VERSION
#DEBUG
echo "Prosseguiria..."
exit

"jre${JRE}"


set_arch

echo "Configurando o diretório onde a nova versão do Java será armazenada"
PATHJAVA="/opt/java-${ARCHPLUGIN}"
[ -d "${PATHJAVA}" ] || mkdir -p "${PATHJAVA}"
cd "${PATHJAVA}"


#Arquivo binário baixado do site do Java
if [ "${VERSION:0:2}" == "6u" ]; then
    DOWNLOADEDJAVA="java-${ARCHPLUGIN}-${VERSION}.bin"
else
    DOWNLOADEDJAVA="java-${ARCHPLUGIN}-${VERSION}.tar.gz"
fi
#

getjava

makealternatives

echo "Done"

