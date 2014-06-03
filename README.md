get-java
========

Obtém a última versão da Oracle JRE e instala no seu Debian/Ubuntu.

Execute este script como usuário 'root' para baixar e instalar a última versão
da Oracle JRE em seu sistema Linux Debian ou Ubuntu.

COMO FUNCIONA
-------------

O script verifica a arquitetura do seu sistema (32bits ou 64bits), baixa e 
instala a versão adequada da JRE em /opt/java-$ARCH.

Após instalada o script se encarrega de criar todos os links necessários para
que esta se torne a máquina JAva padrão do seu sistema e possa ser utilizada 
pelos navegadores web (testado apenas com Firefox e Google Chrome).

COMO USAR
---------
Após baixar o arquivo digite:

$ sudo su -
# chmod +x wrb-getjava.sh
# ./wrb-getjava.sh

