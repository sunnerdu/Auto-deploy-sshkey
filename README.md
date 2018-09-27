### Auto-deploy-sshkey
- *function* : 
auto deploy/update/del ssh-key.pub to each nodes in DevOps
- *statement:*
```
[root@jam Auto-deploy-sshkey]# ll
total 24
-rwxr-xr-x 1 root root 2385 Sep 27 13:40 Auto_ssh-copy.sh
-rw-r--r-- 1 root root   62 Sep 26 18:20 ip.txt
-rw-r--r-- 1 root root  199 Sep 27 13:39 README.md
-rw-r--r-- 1 root root   65 Sep 26 18:37 sshkey_add.log  
-rw-r--r-- 1 root root  127 Sep 26 18:37 sshkey_del.log
-rw-r--r-- 1 root root   65 Sep 27 16:53 sshkey_update.log

[root@jam Auto-deploy-sshkey]# bash Auto_ssh-copy.sh 

Please select tomcat server:
	1. Auto Publish id_rsa.pub
	2. Auto Delete id_rsa.pub
	3. Auto Update id_rsa.pub
Please input a number: 2


```


