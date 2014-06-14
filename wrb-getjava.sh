#!/bin/bash

#Download do Java oficial da Oracle - para instalação no Debian/Ubuntu
#Welington Braga - www.welrbraga.eti.br

#WBRAGA - 2011-12-30
#WBRAGA - 2012-04-17 - Não executa se o usuário não for o root

#URLS obtidas em http://www.java.com/pt_BR/download/manual.jsp

#2011-12-30 JRE SE 6u30
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=58119"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=58117"
VERSION="6u30"

#2012-03-02 JRE SE 6u31
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=59623"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=59621"
VERSION="6u31"

#2012-08-24 JRE SE 6u34
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=66975"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=66973"
VERSION="6u34"

#2012-10-14 JRE SE 6u35
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=68286"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=68284"
VERSION="6u35"

#2012-12-27 JRE SE 6u38
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71305"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71303"
VERSION="6u38"

#2012-03-02 JRE SE 7u4 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=63204"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=63202"
VERSION="7u4"

#2012-08-21 JRE SE 7u6 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=67388"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=67386"
VERSION="7u6"

#2012-10-14 JRE SE 7u7 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=68236"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=66234"
VERSION="7u7"

#2012-12-27 JRE SE 7u10 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71828"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71826"
VERSION="7u10"

#2013-01-19 JRE SE 7u11 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=73134"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=73132"
VERSION="7u11"

#2013-02-24 JRE SE 7u15 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=74774"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=74772"
VERSION="7u15"

#2013-03-19 JRE SE 7u17 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=75252"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=75250"
VERSION="7u17"

#2013-04-19 JRE SE 7u21 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=76853"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=76851"
VERSION="7u21"

#2013-06-26 JRE SE 7u25 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=78697"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=78695"
VERSION="7u25"

#2013-09-12 JRE SE 7u40 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=80805"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=80803"
VERSION="7u40"

#2013-10-20 JRE SE 7u45 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=81812"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=81810"
VERSION="7u45"


#2014-01-23 JRE SE 7u51 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=83376"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=83374"
VERSION="7u51"

#2014-06-02 JRE SE 7u60 - O arquivo para 32bits não é executável
URL64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=90216"
URL32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=90214"
VERSION="7u60"

ARCH=`uname -m`
if [ "${ARCH}" == "x86_64" ]; then
    echo -n "Selecionada versão 64bits"
    URL=${URL64}
    ARCHPLUGIN="amd64"
# desde  a versao 12.04 o ubuntu usa o arquivo libnpjp2.so como plugin
    FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
    #Debian e Ubuntu Lucid usem este:
#    FILEPLUGIN="lib/${ARCHPLUGIN}/libjavaplugin_jni.so"
#    if [ -f /etc/lsb-release ]; then
#        . /etc/lsb-release
#        if [ "$DISTRIB_ID" == "Ubuntu" ] && [ "$DISTRIB_RELEASE" == "12.04" ]; then
#            echo -n " para Ubuntu 12.04"
#            FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
#        fi
#        if [ "$DISTRIB_ID" == "Ubuntu" ] && [ "$DISTRIB_RELEASE" == "13.04" ]; then
#            echo -n " para Ubuntu 13.04"
#            FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
#        fi
        echo ""
#
#    fi
else
    echo "Selecionada versão 32bits"
    URL=${URL32}
    ARCHPLUGIN="i386"
    FILEPLUGIN="lib/${ARCHPLUGIN}/libnpjp2.so"
fi

if [ "$UID" != "0" ]; then
	echo "Você precisa ser administrador para conseguir instalar a máquina Java em seu sistema"
	echo "Tente novamente com: sudo $0"
	exit
fi

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
export DOWNLOADEDJAVA


function getjava() {
    echo "Obtendo e instalando o Java"
    wget "${URL}" -O ${DOWNLOADEDJAVA}

    if [ "${VERSION:0:2}" == "6u" ]; then
        chmod +x ${DOWNLOADEDJAVA}
        ./${DOWNLOADEDJAVA}
    else
        tar xzf ${DOWNLOADEDJAVA}
    fi
}

function makealternatives() {

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

getjava
makealternatives

echo "Done"

