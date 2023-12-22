#!/bin/bash

cp ./symbols/60 /usr/share/X11/xkb/symbols/

# Paths to the destination files
base_dst_lst="/usr/share/X11/xkb/rules/base.lst"
evdev_dst_lst="/usr/share/X11/xkb/rules/evdev.lst"
base_dst_xml="/usr/share/X11/xkb/rules/base.xml"
evdev_dst_xml="/usr/share/X11/xkb/rules/evdev.xml"
pl_dst="/usr/share/X11/xkb/symbols/pl"

# Paths to the source files
base_src_lst="./rules/base.lst"
evdev_src_lst="./rules/evdev.lst"
base_src_xml="./rules/base.xml"
evdev_src_xml="./rules/evdev.xml"
pl_src="./symbols/pl"

# Search for the insertion lines
line_number=$(grep -n "pl: Polish" $base_dst_lst | head -n1 | cut -d: -f1)
line_number2=$(grep -n "pl: Polish" $evdev_dst_lst | head -n1 | cut -d: -f1)
line_number3=$(grep -n "Polish (" $base_dst_xml | head -n1 | cut -d: -f1)
line_number4=$(grep -n "Polish (" $evdev_dst_xml | head -n1 | cut -d: -f1)
line_number5=$(grep -nE "^\};$" $pl_dst | head -n1 | cut -d: -f1)

# Insert the src contents after the found line into the dst
sed -i "${line_number}r ${base_src_lst}" "$base_dst_lst"
sed -i "${line_number2}r ${evdev_src_lst}" "$evdev_dst_lst"
sed -i "$(($line_number3+2))r ${base_src_xml}" "$base_dst_xml"
sed -i "$(($line_number4+2))r ${evdev_src_xml}" "$evdev_dst_xml"
sed -i "${line_number5}r ${pl_src}" "$pl_dst"

echo "Script executed successfully."



