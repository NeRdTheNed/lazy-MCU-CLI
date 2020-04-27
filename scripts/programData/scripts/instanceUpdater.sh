# https://github.com/NeRdTheNed/MCUpdater-server-scripts

UNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR="$(dirname "$UNDIR")"

echo "Instance Updater."
echo "Allows you to update an instance from the terminal!"
echo 

# debug stuff
# echo "Script launched from $DIR"
# echo "Script at $DIR/$BASH_SOURCE"
# echo 

# check if config file exists
if [ ! -f $DIR/config/packConfig.txt ]; then
    echo "You don't have a config file!"
    echo "Use the config generator to make one out of a XML pack link,"
    echo "or ask NeRd for one!"
    echo "Script exiting."
    # I'm assuming only the people I send this will ever use these scripts
    # If you can't contact me, good luck fixing my bugs lmao
	exit
fi

# debug stuff
# while IFS= read -r line; do
    # echo "Text read from file: $line"
# done < $DIR/config.txt

packuUl=$(sed '1q;d' $DIR/config/packConfig.txt)
serverID=$(sed '2q;d' $DIR/config/packConfig.txt)

if test -e "$DIR/libraries/MCU-CLI-latest.jar" 
then
	zflag=(-z "$DIR/libraries/MCU-CLI-latest.jar")
else 
	zflag=()
fi
curl -o "$DIR/libraries/MCU-CLI-latest.jar" "${zflag[@]}" "https://files.mcupdater.com/MCU-CLI-latest.jar"

# runs MCU-CLI with the specified arguments
echo "Starting server update check!"
MCUpdaterCommand="java -jar $DIR/libraries/MCU-CLI-latest.jar --pack $packuUl --path $DIR/libraries/instaledPack --server $serverID --side SERVER"
echo "Command is $MCUpdaterCommand"
echo "MCUpdater output:"
echo
$MCUpdaterCommand
echo 
echo "Copying eula.txt to the right place so you don't have to!"
cp $DIR/libraries/eula.txt $DIR/libraries/instaledPack/eula.txt
echo
echo "Done!"