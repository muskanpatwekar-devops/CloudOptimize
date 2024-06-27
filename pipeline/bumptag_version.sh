#!/bin/bash
#
#

#Creating bump function

bump_version(){
    local version=$1
    local part=$2

 # remove the v from version
 version="${version#v}"

 #Split the verion in major,minor,patch
 IFS='.' read -r -a version_array <<< "$version"

 # Increment the specified part (major, minor, or patch)

 case $part in
 major) ((version_array[0]++)); version_array[1]=0; version_array[2]=0;;
 minor) ((version_array[1]++)); version_array[2]=0;;
 patch) ((version_array[2]++));;
 *) echo "Invalid version part specified, $part"; exit 1 ;;
 esac 

 # Join the version parts back
 new_version="${version_array[0]}.${version_array[1]}.${version_array[2]}"
 echo "$new_version"
}

# current tag
current_tag=$(git describe --abbrev=0 --tags)

# Check if an argument is provided

if [[ $# -eq 0 ]]; then
echo "USAGE : $0 <major|minor|patch>"
exit 1
fi

# Bump the version based on the provided argument

new_tag=$(bump_version "$current_tag" "$1")
echo -n "v$new_tag"