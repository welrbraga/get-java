BIN=/usr/local/bin
SBIN=/usr/local/sbin
ETC=/usr/local/etc
CRONPATH=/etc/cron.daily

USER=root
GROUP=root
PERM=0755
FILENAME=wrb-getjava.sh
FILENAMEINSTALL=wrb-getjava
CRONFILE=getjava-cron

install: installscript installcron installjava

installscript:
	@if [ -f $(BIN)/$(FILENAME) ]; then sudo rm -v $(BIN)/$(FILENAME); fi
	@sudo install -Cv -o $(USER) -g $(GROUP) -m $(PERM) $(FILENAME) $(BIN)/$(FILENAMEINSTALL)

installjava:
	@sudo $(FILENAMEINSTALL) -n

uninstall:
	@sudo rm -v $(BIN)/$(FILENAMEINSTALL) $(CRONPATH)/$(CRONFILE)

installcron:
	@#Instala o agendamento no cron.daily
	@sudo install -o $(USER) -g $(GROUP) -m 0755 $(CRONFILE) $(CRONPATH)
	@#Configura o Anacron -somente se não houver uma configuração pre-existente
	@grep getjava /etc/anacrontab >/dev/null || \
		echo '1       2       getjava /etc/cron.daily/getjava-cron' |sudo tee -a /etc/anacrontab
