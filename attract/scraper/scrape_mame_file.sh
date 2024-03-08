#!/bin/bash
set -x

database_file="MAME_all.txt"

main_path="/run/media/xxx/Mame"

rom_path=$main_path"/roms"
rom_clones=$main_path"/roms_clones"
rom_unknown=$main_path"/roms_unknown"

rom_flyer=$main_path"/flyer"
rom_marquee=$main_path"/marquee"
rom_snap=$main_path"/snap"
rom_wheel=$main_path"/wheel"

rom_clones_flyer=$main_path"/flyer_clones"
rom_clones_marquee=$main_path"/marquee_clones"
rom_clones_snap=$main_path"/snap_clones"
rom_clones_wheel=$main_path"/wheel_clones"

#FIELD NUMBERS
#4- Parent rom (empty if parent)
#7- category
#8- players 1P, 2P sim/alt, 3P sim/alt, 4P sim/alt
#9- rotation 0, 90, 270 (vertical shooters) degrees

#print all clones to a file
awk -F\; '$4 {print $1}' $database_file > list.tmp

while read clone
do
	#move clone roms to rom_clones dir
	#eval mv $rom_path/$clone.* $rom_clones
	#move clone roms to rom_clones dir
	eval mv $rom_flyer/$clone.* $rom_clones_flyer
	#move clone roms to rom_clones dir
	eval mv $rom_marquee/$clone.* $rom_clones_marquee
	#move clone roms to rom_clones dir
	eval mv $rom_snap/$clone.* $rom_clones_snap
	#move clone roms to rom_clones dir
	eval mv $rom_wheel/$clone.* $rom_clones_wheel
done < list.tmp
