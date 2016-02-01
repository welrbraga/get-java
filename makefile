BIN=/usr/local/bin
SBIN=/usr/local/sbin
ETC=/usr/local/etc

USER=root
GROUP=root
PERM=0755
FILENAME=wrb-getjava.sh
CRONFILE=getjava-cron

install: installscript installjava installcron

#Instala o script
installscript:
	sudo install -o $(USER) -g $(GROUP) -m $(PERM) $(FILENAME) $(BIN)

#Instala/atualiza o JRE
installjava:
	sudo $(FILENAME) -n

uninstall:
	sudo rm $(BIN)/$(FILENAME)

#instala a agenda de atualização
installcron:
	#Remove o agendamento do cron
	[ -f /etc/cron.d/$(CRONFILE) ] && sudo rm /etc/cron.d/$(CRONFILE)
	#Instala o agendamento no anacron
	sudo install -o $(USER) -g $(GROUP) -m 0755 $(CRONFILE) /etc/cron.daily

