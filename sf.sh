    cd ~/znxt
    sudo apt-get update -y && sudo apt-get install expect -y

    nad=$(ls Nusantara*Gapps*.zip)
    arrow=$(ls Arrow*.zip)
    
	# Upload
	expect -c "
	spawn sftp $SF_USERNAME@frs.sourceforge.net
	expect \"yes/no\"
	send \"yes\r\"
	expect \"Password\"
	send \"$SF_PASS\r\"
	expect \"sftp>\"
	send \"ls /home/pfs/project\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd /home/pfs/project/znxt_project/maple_dsds\r\"
	set timeout -1
	expect \"sftp> \"
	send \"mkdir nusantara-11\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd /nusantara-11\r\"
	set timeout -1
	send \"put $nad\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"cd /home/pfs/project/znxt_project/maple_dsds\r\"
	set timeout -1
	expect \"sftp>\"
	send \"mkdir arrow-12.0\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd /arrow-12.0\r\"
	set timeout -1
	send \"put $arrow\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"bye\r\"
	interact"
