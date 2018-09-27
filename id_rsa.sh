#!/bin/bash
#Auth: sunner_du
#Date:2018-9-26
#Email:dyh1243208731@163.com
#Function:auto copy/update/del id_rsa.pub to each node
while :; do echo
    echo 'Please select tomcat server:'
    echo -e "\t${CMSG}1${CEND}. Auto Publish id_rsa.pub"
    echo -e "\t${CMSG}2${CEND}. Auto Delete id_rsa.pub"
    echo -e "\t${CMSG}3${CEND}. Auto Update id_rsa.pub"
	read -p "Please input a number: " sshkey_option
	if [[ ! ${sshkey_option} =~ ^[1-3]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~3${CEND}"
	
	else
		if [ "${sshkey_option}" == '1' ]; then
			for p in $(cat ./CIP)  
			do   
				ip=$(echo "$p"|cut -f1 -d":")         
				password=$(echo "$p"|cut -f2 -d":") 
				expect -c "   
				spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$ip  
				expect {   
                    \"*yes/no*\" {send \"yes\r\"; exp_continue}   
                    \"*password*\" {send \"$password\r\"; exp_continue}   
                    \"*Password*\" {send \"$password\r\";}   
						}   
				"   
			done    
			for h in $(cat ./CIP|cut -f1 -d":")  
				do  
					ssh root@$h ' ifconfig ' 
					if [ $? -ne 0 ]; then
						echo "$h failed" >> sshkey_add.log
					else
						echo "$h succeed" >> sshkey_add.log
					fi   
				done
                elif [ "${sshkey_option}" == '2' ]; then
			for h in $(cat ./CIP|cut -f1 -d":")
				do      
					ssh root@$h 'mv /root/.ssh/authorized_keys /root/.ssh/authorized_keys_`date +%F`'
					if [ $? -ne 0 ]; then
						echo "$h failed" >> sshkey_del.log
					else
						echo "$h succeed" >> sshkey_del.log
					fi   
				done
				
		elif [ "${sshkey_option}" == '3' ]; then
				for h in $(cat ./CIP|cut -f1 -d":")
				do
					ssh root@$h 'mv /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub_`date+%F`'
					ip=$(echo "$p"|cut -f1 -d":")         
					password=$(echo "$p"|cut -f2 -d":") 
					expect -c "   
					spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$ip  
					expect {   
                    \"*yes/no*\" {send \"yes\r\"; exp_continue}   
                    \"*password*\" {send \"$password\r\"; exp_continue}   
                    \"*Password*\" {send \"$password\r\";}   
						}   
					"   
					if [ $? -ne 0 ]; then
						echo "$h failed" >> sshkey_update.log
					else
						echo "$h succeed" >> sshkey_update.log
					fi   
		     	        done
		      fi
		   break
	    fi
   break
done
