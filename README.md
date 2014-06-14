get-java
========

Obtém, instala e configura a última versão da Oracle JRE no seu Debian/Ubuntu.

Execute este script como usuário 'root' para baixar e instalar a última versão
da Oracle JRE em seu sistema Linux Debian ou Ubuntu.

COMO FUNCIONA
-------------

O script verifica a arquitetura do seu sistema (32bits ou 64bits), baixa e 
instala a versão adequada da JRE em /opt/java-$ARCH.

Após instalada o script se encarrega de criar todos os links necessários para
que esta se torne a máquina Java padrão do seu sistema e possa ser utilizada 
pelos navegadores web (testado apenas com Firefox e Google Chrome).

COMO USAR
---------

Após baixar o arquivo digite:

$ sudo chmod +x wrb-getjava.sh

$ sudo ./wrb-getjava.sh

Observações
-----------

Caso o pacoe Java já tenha sido baixado antes e você execute o script pela segunda
vez o pacote não será baixado novamente. Caso ele tenha vindo corrompido da vez 
anterior você deverá removê-lo manualmente e então executar o script outra vez.

