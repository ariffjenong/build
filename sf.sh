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
	expect \"sftp> \"
	send \"mkdir '/home/pfs/project/maple_dsds/nusantara-11'\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd '/home/pfs/project/maple_dsds/nusantara-11'\r\"
	set timeout -1
	send \"put $nad\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"bye\r\"
	interact"

	# Upload
	expect -c "
	spawn sftp $SF_USERNAME@frs.sourceforge.net
	expect \"yes/no\"
	send \"yes\r\"
	expect \"Password\"
	send \"$SF_PASS\r\"
	expect \"sftp> \"
	send \"mkdir '/home/pfs/project/maple_dsds/arrow-12.0'\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd '/home/pfs/project/maple_dsds/arrow-12.0'\r\"
	set timeout -1
	send \"put $arrow\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"bye\r\"
	interact"

	# Post
	curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully..!!!
	Link: https://sourceforge.net/p/maple_dsds/nusantara-11/$(ls Nusantara*.zip)
	Dev : Arif JeNong
	Product : ==== $nad ====
	Device : maple_dsds
	Server Host : cirrus-ci
	Build Type : UNOFFICIAL
	Android : 11
	Date : $(env TZ=Asia/Jakarta date)" https://api.telegram.org/$TG_TOKEN/sendMessage

	curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully..!!!
	Link: https://sourceforge.net/p/maple_dsds/arrow-12.0/$arrow
	Dev : Arif JeNong
	Product : ==== $arrow ====
	Device : maple_dsds
	Server Host : cirrus-ci
	Build Type : UNOFFICIAL
	Android : 12
	Date : $(env TZ=Asia/Jakarta date)" https://api.telegram.org/$TG_TOKEN/sendMessage
