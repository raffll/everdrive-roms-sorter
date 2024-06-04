#!/bin/bash

move2letters () {

for x in {a..z} {A..Z}
do
	for y in {a..z} {A..Z}
	do
		if compgen -G "${x}${y}*.*" > /dev/null; then
			echo "${x^^}/${x^^}${y^^}"
			mkdir -p "${x^^}/${x^^}${y^^}"
			mv ${x}${y}*.* "${x^^}/${x^^}${y^^}"
		fi
	done
	for y in '-' '+' '.' "'"
	do
		if compgen -G "${x}${y}*.*" > /dev/null; then
			echo "${x^^}/${x^^}#"
			mkdir -p "${x^^}/${x^^}#"
			mv ${x}${y}*.* "${x^^}/${x^^}#"
		fi
	done
done

for x in {0..9}
do
	if compgen -G "${x}*.*" > /dev/null; then
		echo "#1"
		mkdir -p "#1"
		mv ${x}*.* "#1"
	fi
done

echo "#2"
mkdir -p "#2"
mv *.* "#2"
}

#echo "Unpacking..."
#unzip -q "*.zip" &&

echo "Removing..."
rm *.zip

move2letters
