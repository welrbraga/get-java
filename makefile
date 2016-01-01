BIN=/usr/local/bin
SBIN=/usr/local/sbin
ETC=/usr/local/etc

USER=root
GROUP=root
PERM=0755
FILENAME=wrb-getjava.sh


install: installscript installjava

#Instala o script
installscript:
	sudo install -o $(USER) -g $(GROUP) -m $(PERM) $(FILENAME) $(BIN)

#Instala/atualiza o JRE
installjava:
	sudo $(FILENAME) -n

uninstall:
	sudo rm $(BIN)/$(FILENAME)
#------

