tweet () {

    # Read input from user
    read -p "Enter \"tweet\" text: " content

    # Get current date and time as a string
    dateForFilename=`date +'%Y%m%d'`
    dateForPost=`date +'%Y-%m-%d'`

    # Make sure today's date is what the user wants
    asking=true
    while [ "$asking" = true ]; do
        read -p "Is the date $dateForPost ok? " yn
        case $yn in
            [Yy]* )
                asking=false
                ;;
            [Nn]* )
                # if it's not, let them enter new dates
                read -p "Enter new date for filename: " dateForFilename
                read -p "Enter new date for post: " dateForPost
                asking=false
                ;;
            * ) echo "Please answer yes or no.";;
        esac
    done

    # write the tweet file if we won't overwrite
    if [ -f "${dateForFilename}.txt" ]; then
        echo "File ${dateForFilename}.txt already exists! Not gonna overwrite!"
        return 1
    fi

    cat >${dateForFilename}.txt <<EOL
- ${content}
${dateForPost}
EOL
    echo "File ${dateForFilename}.txt created!"

    while true; do
        read -p "Want to run Pupate as well? " yn2
        case $yn2 in
            [Yy]* )
                cd ../..;sudo pupate;cd -
                break
                ;;
            [Nn]* )
                break
                ;;
            * ) echo "Please answer yes or no.";;
        esac
    done

    return 0
}
