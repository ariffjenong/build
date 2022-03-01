

#    cd ~/znxt
    cd ~/rom/out/target/product/maple_dsds


    sudo apt-get install expect -y

    product=$(ls *UNOFFICIAL*.zip)
    project=xperia-xz-premium/maple_dsds
    
	# Upload
	expect -c "
	spawn sftp $SF_USERNAME@frs.sourceforge.net:/home/pfs/project/$project
	expect \"yes/no\"
	send \"yes\r\"
	expect \"Password\"
	send \"$SF_PASS\r\"
	expect \"sftp> \"
	send \"mkdir $ROM_PROJECT\r\"
	set timeout -1
	expect \"sftp> \"
	send \"cd $ROM_PROJECT\r\"
	set timeout -1
	send \"put $product\r\"
	expect \"Uploading\"
	expect \"100%\"
	expect \"sftp>\"
	send \"bye\r\"
	interact"

	# Post
	curl -s -v -F "chat_id=$TG_CHAT_ID" -F "parse_mode=html" -F text="Build completed successfully!!!
	Link: https://sourceforge.net/p/$project/$ROM_PROJECT/$product
	Dev : ""Arif JeNong""
	Product : ""$product""
	Device : ""maple_dsds""
	Server Host : cirrus-ci
	Date : ""$(env TZ=Asia/Jakarta date)""" https://api.telegram.org/$TG_TOKEN/sendMessage
