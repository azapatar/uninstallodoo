#!/bin/bash

################################################################################
# Script para desinstalar Odoo 17 en Ubuntu 16.04, 18.04, 20.04 y 22.04
# Autor: Asistente de IA de Anthropic
#-------------------------------------------------------------------------------
# Este script desinstalará Odoo de tu servidor Ubuntu. Deberás proporcionar
# algunos parámetros del script de instalación original para realizar una
# desinstalación completa.
################################################################################

OE_USER="odoo"
OE_HOME="/$OE_USER"
OE_HOME_EXT="/$OE_USER/${OE_USER}-server"
OE_CONFIG="${OE_USER}-server"

# Detener el servicio de Odoo
echo -e "\n---- Deteniendo el servicio de Odoo ----"
sudo service $OE_CONFIG stop

# Eliminar el servicio de inicio
echo -e "\n---- Eliminando el servicio de inicio ----"
sudo update-rc.d -f $OE_CONFIG remove

# Eliminar archivos de configuración
echo -e "\n---- Eliminando archivos de configuración ----"
sudo rm /etc/init.d/$OE_CONFIG
sudo rm /etc/${OE_CONFIG}.conf

# Eliminar directorio de Odoo
echo -e "\n---- Eliminando directorio de Odoo ----"
sudo rm -r $OE_HOME_EXT

# Eliminar directorio de modulos personalizados
echo -e "\n---- Eliminando directorio de modulos personalizados ----"
sudo rm -r $OE_HOME/custom

# Eliminar directorio de empresa (si existe)
if [ -d "$OE_HOME/enterprise" ]; then
    echo -e "\n---- Eliminando directorio de empresa ----"
    sudo rm -r $OE_HOME/enterprise
fi

# Eliminar usuario de Odoo
echo -e "\n---- Eliminando usuario de Odoo ----"
sudo deluser --remove-home $OE_USER

# Eliminar directorio de logs
echo -e "\n---- Eliminando directorio de logs ----"
sudo rm -r /var/log/$OE_USER

# Desinstalar Nginx (si esta instalado)
if [ -f /etc/nginx/sites-available/$WEBSITE_NAME ]; then
    echo -e "\n---- Desinstalando Nginx ----"
    sudo rm /etc/nginx/sites-available/$WEBSITE_NAME
    sudo rm /etc/nginx/sites-enabled/$WEBSITE_NAME
    sudo apt-get purge nginx nginx-common -y
fi

# Desinstalar PostgreSQL (si esta instalado)
echo -e "\n---- Desinstalando PostgreSQL ----"
sudo apt-get purge postgresql* -y

echo -e "\n---- Odoo ha sido desinstalado correctamente ----"