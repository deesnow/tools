#!/bin/bash

function funk() {
	echo "Esxi host : $line" >> output.txt
	echo "-------------------------------------" >> output.txt
	if ping -c1 -W1 $line
	
	then
	ssh -n  -oStrictHostKeyChecking=no root@$line 'esxcli system version get && esxcli network nic get -n vmnic4 && esxcli network nic get -n vmnic5 && esxcfg-advcfg -g /DataMover/HardwareAcceleratedMove && esxcfg-advcfg -g /DataMover/HardwareAcceleratedInit && esxcfg-advcfg -g /VMFS3/HardwareAcceleratedLocking' >> output.txt
	echo "-------------------------------------" >> output.txt
	echo "                                     " >> output.txt
	
	else
	echo "***** HOST $line is unreachable *****" >> output.txt
	echo "                                     " >> output.txt
	
	
}



while IFS= read -r line
do
	echo "Logging into $line"
	funk
	echo "$line is DONE"

done <"$1"