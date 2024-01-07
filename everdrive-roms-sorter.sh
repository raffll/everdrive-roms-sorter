#!/bin/bash

ext="${2}"

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

	#cd "$dir"
	#move2letters
	#cd ..
fi
}

#echo "Unpacking..."
#unzip -q "*.zip" &&
#
#echo "Removing..."
#rm *.zip &&

dir="${1} (Pirate)"
keyword="(Pirate)"
move2folder

dir="${1} (Aftermarket)"
keyword="(Aftermarket)"
move2folder

dir="${1} (Beta)"
keyword="(Beta"
move2folder

dir="${1} (Sample)"
keyword="(Sample"
move2folder

dir="${1} (Proto)"
keyword="(Proto"
move2folder

for i in "(Virtual" "Online)" "(Switch" "Collection)" "(Collection"  "Classics)" "Console)" "Edition)" "(Retro-Bit Generations)" "(iam8bit)" "(Limited Run Games)" "(Disney " "(Namcot " "(Namco " "(Konami " "(Capcom"
do 
	dir="${1} (Collection, Edition, Online...)"
	keyword="${i}"
	move2folder
done

for i in "(USA" "(Japan, USA" "(World" "(Canada"
do 
	dir="${1} (USA, Canada, World)"
	keyword="${i}"
	move2folder
done

dir="${1} (Japan)"
keyword="(Japan"
move2folder

dir="${1} (Europe, Asia, Australia...)"
keyword=".${ext}"
move2folder

#for i in "(Europe" "(Germany" "(France" "(Italy" "(Sweden" "(Spain"
#do 
#	dir="${1} (Europe)"
#	keyword="${i}"
#	move2folder
#done
#
#for i in "(Asia" "(China" "(Brazil" "(Australia" "(Russia" "(Korea" "(Taiwan"
#do 
#	dir="${1} ${i})"
#	keyword="${i}"
#	move2folder
#done
