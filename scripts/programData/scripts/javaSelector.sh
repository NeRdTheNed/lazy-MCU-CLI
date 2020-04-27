echo "Java selector."
echo "An unhelpful helpfull tool!"
echo

perConfigArguments=(`find $DIR/config/defaultArgs -maxdepth 1 -name "*.txt"`)
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

else 
   	echo "No .jar files found in instance directory!"
   	echo "Which is weird, because they should be there."
   	echo "Try re-installing or updating your instance!"
   	echo
fi

echo "Unfortunately, this script is kinda dumb."
echo "This is because I can't be bothered to write a real java version detector."
echo "Proceed at own risk."


/usr/libexec/java_home -V