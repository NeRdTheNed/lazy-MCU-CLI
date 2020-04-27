# https://github.com/NeRdTheNed/MCUpdater-server-scripts

UNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$(dirname "$UNDIR")"

echo "Config generator."
echo "Generates configs so you don't have to!"
echo 

# check if config file already exists
if [ -f $DIR/config/packConfig.txt ]; then
    echo "You already have a config file! Generate a new one?"
    select yn in "Yes" "No"; do
    	case $yn in
        	Yes ) rm $DIR/config/packConfig.txt; echo; break;;
        	No ) exit;;
    	esac
    done
fi

echo "Please enter the pack URL: "
read USERIN

echo $USERIN > $DIR/config/packConfig.txt

echo

# note: this will always generate a file named "pack.xml" regardless of what (or if anything) was downloaded
# todo: find a better way to do it
curl $USERIN >| $DIR/libraries/pack.xml

echo
echo "Download done!"
echo

# sanity check, I guess?
if grep -Fxq "$FILENAME" $DIR/libraries/pack.xml
then

	# god I hate bash, have some arrays
	listOfServIDs=()
	
	searchstring="Server id="
	
	# this bit loops over every server id in the pack.xml file. most packs just have one, but it's good to handle all cases.
	while IFS= read -r result; do
		
		# I really hope that this works for every pack lmao
		# not sure if the format demands it be consistant but every one I've check works
		cutServerID=$(echo $result | cut -d'"' -f 2)
		
		listOfServIDs+=("$cutServerID")
		
	done < <(grep -F "Server id=" $DIR/libraries/pack.xml)
	
	# if there's a thing
	if [ "${#listOfServIDs[@]}" -ge 1 ]; then
	
		echo "Server IDs found: ${#listOfServIDs[@]}"
		echo "Choose which one you'd like to use!"
		
		# makes a select out of all server ids and lets user choose
    	select numberSelection in "${listOfServIDs[@]}"; do
    		if [[ " ${listOfServIDs[*]} " == *" $numberSelection "* ]]; then
    			echo Choosen "$numberSelection"!
    			echo $numberSelection >> $DIR/config/packConfig.txt
    			break
    		else 
    			echo "Your selection is not in the list of server IDs!"
    			echo "Press enter without typing anything to see the whole list again!"
    		fi
    	done
  		
	else 
		# if you've entered a wrong url or downloaded something that doesn't have a server ID
		echo "The downloaded pack does not appear to contain a server ID!"
		echo "Maybe you downloaded the wrong file?"
		# report a bug if this is wrong
		echo "Deleting files and exiting..."
		rm $DIR/libraries/pack.xml
		rm $DIR/config/packConfig.txt
		exit
	fi	
else
	echo "The code should never get here, because bash will write a blank file even if the URL is invalid!"
	echo "If you're here, then please re-instal MacOS or whatever posix compliant terminal you're on!"
	echo "Actually, don't do that, bad idea. There's probably just a bug in this script."
	echo "I'm just having fun because I think it should actually be impossible to get here."
	echo "Report this bug at https://github.com/NeRdTheNed/MCUpdater-server-scripts"
	echo
	exit
fi 

# debug
# echo 
# echo "Contents of config file:"

# while IFS= read -r line; do
    # echo "	$line"
# done < $DIR/packConfig/config.txt
echo 
echo "Done creating config file!"
echo "Run the launch script to download and run your server!"
echo

# fin