get-java
========

Obtém, instala e configura a última versão da Oracle JRE no seu Debian/Ubuntu.

Execute este script como usuário 'root' para baixar e instalar a última versão
da Oracle JRE em seu sistema Linux Debian ou Ubuntu.

COMO FUNCIONA
-------------

O script verifica a arquitetura do seu sistema (32bits ou 64bits), baixa e 
instala a versão adequada da JRE em /opt/java-$ARCH.

Após instalado o script se encarrega de criar todos os links necessários para
que esta se torne a máquina Java padrão do seu sistema e possa ser utilizada 
pelos navegadores web (testado apenas com Firefox e Google Chrome**).

** Ver nota sobre o Gogole Chrome ainda neste README.

COMO INSTALAR
-------------

Há três formas de instalar. Você pode escolher a que achar melhor sem que isso 
prejudique o funcionamento script e a instalação da JRE em seu sistema.

Primeira forma (baixando um só arquivo):
- Clique no arquivo "wrb-getjava.sh", com o botão direito do mouse;
- Escolha a opção "Salvar link como"
- Clique no botão "Salvar"
- Pela janela de terminal use o comando "cd" para entrar no diretório onde o 
arquivo foi salvo (geralmente na pasta "Downloads");
- Siga o procedimento descrito na seção "COMO USAR".

Segunda forma (baixando todo o último release):
- Clique no link "releases", no alto da página;
- Abaixo da lista de releases haverá um link para download de cada release 
disponível, em formato "zip" e em formato "tar.gz". Clique no link que você 
achar mais adequado para baixar o arquivo;
- Descompacte o arquivo baixado usando a ferramenta ou comando adequado para o 
formato escolhido (pode usar usando o seu gerenciador de arquivos ou comandos 
unzip e tar pelo terminal);
- Entre na pasta "get-java-XXXX" usando o comando "cd", a linha de comandos;
- Siga o procedimento descrito na seção "COMO USAR".

Terceira forma (mantenha-se atualizado com o git):
- Caso o seu sistema ainda não tenha o git instalado, instale-o com o comando 
"sudo apt-get install git";
- Com o "git" instalado em seu sistema você deverá clonar o repositório no 
endereço "https://github.com/welrbraga/get-java.git", com o comando a seguir:

$ git clone https://github.com/welrbraga/get-java.git

- Siga o procedimento descrito na seção "COMO USAR".

COMO USAR
---------

Após baixar o arquivo digite:

$ sudo chmod +x wrb-getjava.sh

$ sudo ./wrb-getjava.sh [VERSÃO]


Instale e mantenha-se atualizado
--------------------------------

Você poderá instalar o script no seu sistema para que ele possa ser executado
outras vezes de forma a assegurar que você estará sempre com a última versão
do Oracle JRE instalado em sua máquina.

Para executar a instalação, após baixar o último release ou ter clonado o 
repositório Git, execute o comando abaixo:

$ sudo ./INSTALL.sh

O script será instalado em uma pasta de binários do sistema (/usr/local/bin)
e poderá ser executado outras vezes mesmo que você remova o pacote baixado,
seus arquivos ou o diretório clonado.


Nota sobre o download dos pacotes JRE
-------------------------------------

Caso a "VERSÃO" da JRE não seja especificada na linha de comandos será 
baixada/instalada a última versão que o script tiver conhecimento. 

Caso queira baixar e instalar uma versão que não a última, a "VERSÃO" 
de ser informada no formato "7u45", "6u20" etc. Mas só é possível 
baixar/instalar as versões para quais o script tenha as URLs. 

OBS: Por hora, não é possível listar as versões disponíveis. 

Caso o pacote Java já tenha sido baixado antes e você execute o script pela 
segunda vez o pacote não será baixado novamente. No entanto os links para
as alternativas do sistema serão recriadas se necessário.

Caso o pacote tenha vindo corrompido da vez anterior e você precise 
executar o download e a instalação novamente você deverá primeiro
remover manualmente o arquivo danificado, antes de executar o script 
outra vez.

Mais um detalhe sobre o download: Onde eles são salvos
------------------------------------------------------

Versões anteriores do Get-Java baixava o pacote dentro de /opt/java-$ARCH.
As versões mais recentes (a partir do commit 0c20d6c8d8 - release 8u40)
passaram a salvar os pacotes em /var/cache/getjava. Pacotes baixados por
versões antigas do script não são movidos para o novo path e podem ser 
feitas manualmente pelo usuário se desejado.

A partir desta versão citada acima a lista de pacotes que podem ser 
obtidos deixaram de residir no script e passaram a ficar em um arquivo 
volátil que será baixado, também em /var/cache/getjava, todas as vezes
que o script for executado. Isso garante que todas as vezes que a lista 
for atualizada no repositório você poderá obter a versão mais recente do
Oracle JRE sem necessidade de atualizar o script.

Sobre o Google Chrome
---------------------

Desde o Update 35, o Google Chrome deixou de suportar a máquina virtual JVM 7 
em embientes Linux. Portanto se você realmente precisa usar uma JVM no 
Linux+Chrome ou você usa uma JVM 6 (não testei se é verdade), ou tenta usar um 
release do Google Chrome anterior ao 35, lançado em Abril/2014.

Referências a este caso são:
http://blog.chromium.org/2013/09/saying-goodbye-to-our-old-friend-npapi.html
http://java.com/en/download/faq/chrome.xml
http://www.java.com/pt_BR/download/faq/chrome.xml

