#!/bin/bash
info_OS=$(hostnamectl)
if echo "$info_OS" | grep 'Ubuntu'; then
        so="El sistema operativo es Ubuntu"
	      verify=$(apt list --installed)
        if echo "$verify" | grep 'clamav'; then
                echo "--Se estará eliminando el antivirus previamente instalado--"
                sudo apt-get remove clamav clamav-daemon
		            sudo apt-get autoremove
        fi
        echo "--Antivirus instalándose--"
	      sudo apt-get install clamav clamav-daemon	
fi

if echo "$info_OS" | grep 'CentOS'; then
        so="El sistema operativo es CentOS"
        verify=$(yum list installed)
        if echo "$verify" | grep 'clamav'; then
                echo "--Se estará eliminando el antivirus previamente instalado--"
                sudo yum remove install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
        fi
        echo "--Antivirus instalándose--"
        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
	      echo "--Instalando repositorios EPEL--"
	      sudo yum install epel-release
	      verify2=$(yum list updates)
	      echo "--Buscando actualizaciones--"
	      if echo "$verify2" | grep 'updates'; then
		            echo "--Hay actualizaciones disponibles, se realizarán a continuación--"
		            sudo yum update
	      fi		
fi
