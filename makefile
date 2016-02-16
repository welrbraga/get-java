BIN=/usr/local/bin
SBIN=/usr/local/sbin
ETC=/usr/local/etc

USER=root
GROUP=root
PERM=0755
FILENAME=wrb-getjava.sh
CRONFILE=getjava-cron

install: installscript installcron installjava

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
	#Instala o agendamento no cron.daily
	sudo install -o $(USER) -g $(GROUP) -m 0755 $(CRONFILE) /etc/cron.daily
	#Configura o Anacron -somente se não houver uma configuração pre-existente
	grep getjava /etc/anacrontab >/dev/null || \
		echo '1       2       getjava /etc/cron.daily/getjava-cron' |sudo tee -a /etc/anacrontab

