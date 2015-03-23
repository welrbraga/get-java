#!/bin/bash

#Instala o script no diretorio do sistema
sudo install -o root -g root -m 755 wrb-getjava.sh /usr/local/bin

#Executa o script
sudo wrb-getjava.sh -n

