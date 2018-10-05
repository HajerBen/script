# Copyright (c) 2010 
# 
# This file is part of LTE-Sim
# LTE-Sim is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation;
# 
# LTE-Sim is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with LTE-Sim; if not, see <http://www.gnu.org/licenses/>.
#
# Author: Mauricio Iturralde <mauricio.iturralde@irit.fr, mauro@miturralde.com>

#inputs  1 output name, 2 MT file name, 3 FME file name, 4 RR file name, 5 Title, 6 x label, 7 Y label
filename=.temp3.data
# echo "set terminal svg size 600,400 dynamic enhanced fname 'arial'  fsize 11 butt solid" >> plot.gnu
# echo "set terminal svg size 600,400" >> plot.gnu
# echo "set output 'bitmap2.svg'" >> plot.gnu
 echo "set terminal jpeg size 1024,768;" > results/$filename
 echo "set output 'results/$1.jpg';">> results/$filename
 echo "set style  data linespoints" >> results/$filename
 #echo "set style histogram cluster gap 1" >> $filename
# echo "set xtics border in scale 1,0.5 nomirror rotate by -90  offset character 0, 0, 0" >> $filename
# echo "set xtics ($labelxtic)" >> $filename
 echo "set grid" >> results/$filename
 #echo "set boxwidth 0.5 absolute" >> $filename
 echo "set style fill solid 1.0 noborder" >> results/$filename
echo "set key inside right" >> results/$filename
 echo "set xlabel \"$6\"" >> results/$filename
 echo "set ylabel \"$7\"" >> results/$filename
  
 #echo  "set format y \"%.0t*10^%+03T\"" >> $filename #Pour le PLR

 echo "set title \"$5\"" >> results/$filename
 #echo "set yrange [ *:* ] noreverse nowriteback" >> $filename
 #echo "set xrange [ *:* ] noreverse nowriteback" >> $filename
 echo "plot  '$2' using 2:xtic(1) title 'MT', '$3' using 2:xtic(1) title 'FME', '$4' using 2:xtic(1) title 'RR'" >> results/$filename
gnuplot results/$filename
rm -Rf $filename
