    cd ~/znxt
    
	# Upload
	expect -c "
	spawn sftp $SF_USERNAME@frs.sourceforge.net
	expect \"yes/no\"
	send \"yes\r\"
	expect \"Password\"
	send \"$SF_PASS\r\"
	expect \"sftp> \"
	send \"mkdir '/home/pfs/project/nusantara/$DEVICE'\r\"
	set timeout -1
	expect \"sftp>\"
	send \"cd '/home/pfs/project/nusantara/$DEVICE'\r\"
	set timeout -1
	send \"put Nusantara*.zip\r\"
	send \"put *.md5sum\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"bye\r\"
	interact"

	# Post
	curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully in $((BUILD_TIME / 60)):$((BUILD_TIME % 60))
	Link: https://sourceforge.net/p/nusantara/""$DEVICE""/Nusantara*.zip
	Dev : ""Arif JeNong""
	Product : NusantaraProject-ROM
	Device : ""$DEVICE""
	Server Host : cirrus-ci
	Release Type : ""$RELEASE_TYPE""
	Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendDocument
	Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendMessage

