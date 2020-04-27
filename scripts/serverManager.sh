# https://github.com/NeRdTheNed/MCUpdater-server-scripts

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# DIR="$(dirname "$UNDIR")"

# all of these scripts aren't coded very well. I specialise in batch only.
# all scripts are also only tested against macOS. linux or other shell compatibility is probably non existant. 
# message me if it is though, that'd be cool to add to the Github page. 

echo "MCUpdater-CLI wrapper script."
echo "Handles running MCUpdater so you don't have to!"
echo
echo "Made by NeRd. Report bugs at:"
echo "https://github.com/NeRdTheNed/MCUpdater-server-scripts"
echo 

PS3="What do you want to do? "

select opt in createConfig downloadOrUpdateInstance launchServer javaSelector quit; do

echo
  case $opt in
    createConfig)
    echo "Launching configGenerator.sh..."
    echo
    bash $DIR/programData/scripts/configGenerator.sh
      ;;
    downloadOrUpdateInstance)
    echo "Launching instanceUpdater.sh..."
    echo
    bash $DIR/programData/scripts/instanceUpdater.sh
      ;;
    launchServer)
    echo "Launching serverLauncher.sh..."
    echo
    bash $DIR/programData/scripts/serverLauncher.sh
      ;;
    javaSelector)
    echo "Launching javaSelector.sh..."
    echo
    bash $DIR/programData/scripts/javaSelector.sh
      ;;
    quit)
    echo "See you!"
    echo
      break
      ;;
    *) 
      echo "Invalid option $REPLY!"
      echo
      ;;
  esac
done

exit