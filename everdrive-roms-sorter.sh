#!/bin/bash

move2letters () {
for x in {A..Z}
do
	if compgen -G "${x}*.${ext}" > /dev/null; then
		echo "$x"
		mkdir -p ${x}
		mv ${x}*.${ext} ${x}
	fi
done

if compgen -G "*.${ext}" > /dev/null; then
	echo "#"
	mkdir -p "#"
	mv *.${ext} "#"
fi
}

move2folder () {
if compgen -G "*${keyword}*" > /dev/null; then
	echo "Moving to ${dir}..."
	mkdir -p "${dir}"
	find . -maxdepth 1 -name "*${keyword}*" -type f -exec mv {} "./${dir}/" \;
	
	count=$(find "$dir" -type f | wc -l)
	if (( count > 42 )); then
		cd "$dir"
		move2letters
		cd ..
	fi
fi
}

move2folder2 () {
if compgen -G "*${keyword}*" > /dev/null; then
	echo "Moving to ${dir}..."
	mkdir -p "${dir}"
	find . -maxdepth 1 -name "*${keyword}*" -type f -exec mv {} "./${dir}/" \;
fi
}

main () {
misc="4. Misc"
mkdir "${misc}"

dir="Family BASIC"
keyword="(Family BASIC)"
move2folder
mv "${dir}" "${misc}/"

dir="Program"
keyword="\[BIOS\]"
move2folder

dir="Program"
keyword="Program)"
move2folder
mv "${dir}" "${misc}/"

dir="Beta"
keyword="(Beta"
move2folder
mv "${dir}" "${misc}/"

dir="Sample"
keyword="(Sample"
move2folder
mv "${dir}" "${misc}/"

dir="Demo"
keyword="(Demo"
move2folder
mv "${dir}" "${misc}/"

dir="Proto"
keyword="(Proto"
move2folder

dir="Proto"
keyword="Proto)"
move2folder
mv "${dir}" "${misc}/"

for i in "(USA" "(Japan, USA" "(World"
do 
	dir="1. USA, World"
	keyword="${i}"
	move2folder
done

for i in "(Japan"
do 
	dir="2. Japan"
	keyword="${i}"
	move2folder
done

regions="3. Other Regions"
mkdir "${regions}"

for i in "(Europe" "(Germany" "(France" "(Spain" "(Sweden" "(Italy" "(United Kingdom" "(Australia" "(Canada" "(Brazil" "(Asia" "(China" "(Taiwan" "(Korea" "(Russia"
do 
	dir="${i:1}"
	keyword="${i}"
	move2folder
	mv "${dir}" "${regions}/"
done

dir="Unknown"
mkdir "${dir}"
find . -maxdepth 1 -type f -exec mv {} "./${dir}/" \;
mv "${dir}" "${regions}/"
}

### START

files=(*)
ext=$(basename "$files")
ext=${ext##*.}
sys=${ext^^}
echo ${sys}

find . ! -name "*.${ext}*" -type f -delete

#if [ "${sys}" == "GBC" ]; then
#	dir="${sys} (GB Compatible)"
#	keyword="(GB Compatible)"
#	echo "Moving to ${dir}..."
#	mkdir -p "${dir}"
#	find . -maxdepth 1 -name "*${keyword}*" -type f -exec cp -v {} "./${dir}/" \;
#	cd "${dir}"
#fi

dir="6. Translations"
keyword="\[T-En"
move2folder2
if [ -d "${dir}" ]; then
	cd "${dir}"
	main
	cd ..
fi

dir="5. Pirate"
keyword="(Pirate)"
move2folder2
if [ -d "${dir}" ]; then
	cd "${dir}"
	main
	cd ..
fi

coll="3. Collections"
mkdir "${coll}"

for i in "(Namcot " "(Namco "
do 
	dir="Namcot"
	keyword="${i}"
	move2folder
done
mv "${dir}" "${coll}/"

for i in "(Disney " "(The Disney "
do 
	dir="Disney"
	keyword="${i}"
	move2folder
done
mv "${dir}" "${coll}/"

for i in "(Capcom " "(Konami " "(e-Reader " "(GameCube "
do 
	dir="${i:1}"
	dir="${dir::-1}"
	keyword="${i}"
	move2folder
	mv "${dir}" "${coll}/"
done

for i in "(Retro-Bit Generations)" "(iam8bit)" "(Limited Run Games)" "(FamicomBox)" "(Castlevania Anniversary Collection)" "(Contra Anniversary Collection)" "(SNK 40th Anniversary Collection)" "(The Cowabunga Collection)" "(Mega Man Legacy Collection)" "(Ninja JaJaMaru Retro Collection)" "(Metal Gear Solid Collection)" "(Rockman 123)" "(Castlevania Advance Collection)" "(Darius Cozmic Collection)" "(Collection of Mana)"
do 
	dir="${i:1}"
	dir="${dir::-1}"
	keyword="${i}"
	move2folder
	mv "${dir}" "${coll}/"
done

for i in "(Virtual" "Switch Online)" "(Wii"
do 
	dir="Virtual Console"
	keyword="${i}"
	move2folder
done
mv "${dir}" "${coll}/"

dir="4. Aftermarket"
keyword="(Aftermarket)"
move2folder2
if [ -d "${dir}" ]; then
	cd "${dir}"
	main
	cd ..
fi

dir="2. Unlicensed"
keyword="(Unl)"
move2folder2
if [ -d "${dir}" ]; then
	cd "${dir}"
	main
	cd ..
fi

dir="1. Licensed"
mkdir "${dir}"
find . -maxdepth 1 -type f -exec mv {} "./${dir}/" \;
cd "${dir}"
main
cd ..

find . -empty -type d -delete
