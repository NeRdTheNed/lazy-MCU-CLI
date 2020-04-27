# https://github.com/NeRdTheNed/MCUpdater-server-scripts

UNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$(dirname "$UNDIR")"

echo "MCUpdater server launcher script."
echo "Does what it says on the tin!"
echo 

if [ -d "$DIR/libraries/instaledPack" ]; then

	jarFiles=(`find $DIR/libraries/instaledPack -maxdepth 1 -name "*.jar"`)
	if [ ${#jarFiles[@]} -gt 0 ]; then 
    	echo "Found ${#jarFiles[@]} .jar files!"
    	echo "Which one would you like to launch?"
    	echo "(for forge, use forge.jar)"
    	echo "(for vanilla, use minecraft_server(name of version).jar)" 
    	echo "(and for fabric, use (todo: find out the name).jar)"
    	echo 
    	# jar file selection  
    	select numberSelection in "${jarFiles[@]}"; do
    	if [[ " ${jarFiles[*]} " == *" $numberSelection "* ]]; then
    		echo Choosen "$numberSelection"!
    		# echo $numberSelection >> $DIR/packConfig/config.txt
    		break
    	else 
    		echo "Your selection is not in the list of .jar files!"
    		echo "Press enter without typing anything to see the whole list again!"
    	fi
    	done
    	# add argument reader
    	
    	
    	
    	# add launcher
	else 
    	echo "No .jar files found in instance directory!"
    	echo "Which is weird, because they should be there."
    	echo "Try re-installing or updating your instance!"
    	echo
	fi
else
  	echo "No instance directory found!"
  	echo "You should instal / update an instance before running the server launcher!"
  	echo
fi

exit