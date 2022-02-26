#!/bin/bash
rom_output=~/rom/out/target/product/maple_dsds/*.zip
curl -F document=@$rom_output https://api.telegram.org/TG_TOKEN/sendDocument?chat_id=TG_CHAT_ID \
&& cd ~/rom/out/target/product/maple_dsds \
&& ls -lh
