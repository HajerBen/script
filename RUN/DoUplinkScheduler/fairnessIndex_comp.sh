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

# params 1 MINUSERS, 2 MAXUSERS, 3 INTERVAL, 4 FILENAME, 5 FILE, 6 NUMSIM,  7 TYPE, 8 FILE_NAME_PLOT,

FILE=$5   #OUTPUT FILE NAME
NUMSIM=$6  #SIMULATIONS NUMBER
FILENAME=$4   # SIMULATION TYPE NAME
COUNT=1
CELS=1       # NUMBER OF CELLS
TOTALNAME=""

NBUE=$1 #Number of UE's
# variables for values

time=120

until [ $NBUE -gt $2 ]; do

	# bash until loop
#GRAPHIC FOR MT 
	until [ $COUNT -gt $NUMSIM ]; do
	TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_MT_"$NBUE"U"$CELS"C"".sim"
		for bearer in $(seq 0 1 $(( ${NBUE}- 1 )))
	do 
        grep "RX "$7   results/$TOTALNAME  | grep "B ${bearer} " |  awk '{print $8}'  > tmp
      ./compute_throughput.sh tmp  >>tmp_2
	done 
	/home/baati/Bureau/hajer/simulateurs/lte-sim-read-only/TOOLS/make_fairness_index  tmp_2  >> temporal
	rm tmp
	rm tmp_2
	 let COUNT=COUNT+1
	done
	grep "FI" temporal  | awk '{print $2}'  > temporal2
	./compute_average.sh temporal2 | awk '{print "'$NBUE' "$1}' >> results/MT_Y1_$8_$7.dat 
	COUNT=1
	rm temporal
	rm temporal2

    #GRAPHIC FOR FME 
	until [ $COUNT -gt $NUMSIM ]; do
	TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_FME_"$NBUE"U"$CELS"C"".sim"
		for bearer in $(seq 0 1 $(( ${NBUE}- 1 )))
	do 
        grep "RX "$7   results/$TOTALNAME  | grep "B ${bearer} " |  awk '{print $8}'  > tmp
      ./compute_throughput.sh tmp  >>tmp_2
	done 
	/home/baati/Bureau/hajer/simulateurs/lte-sim-read-only/TOOLS/make_fairness_index  tmp_2  >> temporal
	rm tmp
	rm tmp_2
	 let COUNT=COUNT+1
	done
	grep "FI" temporal  | awk '{print $2}'  > temporal2
	./compute_average.sh temporal2 | awk '{print "'$NBUE' "$1}' >> results/FME_Y1_$8_$7.dat 
	COUNT=1
	rm temporal
	rm temporal2

    #GRAPHIC FOR RR
	until [ $COUNT -gt $NUMSIM ]; do
	TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_RR_"$NBUE"U"$CELS"C"".sim"
		for bearer in $(seq 0 1 $(( ${NBUE}- 1 )))
	do 
        grep "RX "$7   results/$TOTALNAME  | grep "B ${bearer} " |  awk '{print $8}'  > tmp
      ./compute_throughput.sh tmp >>tmp_2
	done 
	/home/baati/Bureau/hajer/simulateurs/lte-sim-read-only/TOOLS/make_fairness_index  tmp_2 >> temporal
	rm tmp
	rm tmp_2
	 let COUNT=COUNT+1
	done
	grep "FI" temporal  | awk '{print $2}'  > temporal2
	./compute_average.sh temporal2 | awk '{print "'$NBUE' "$1}' >> results/RR_Y1_$8_$7.dat 
	COUNT=1
	rm temporal
	rm temporal2
#START ANOTHER ALGORITHM
#
#-----> Add code here
#
#END ANOTHER ALGORITHM
 let NBUE=NBUE+$3
done

echo MT  >> results/results_$8_$7.ods
echo Users Value  >> results/results_$8_$7.ods
	grep  " " results/MT_Y1_$8_$7.dat  >> results/results_$8_$7.ods
echo FME  >> results/results_$8_$7.ods
echo Users Value  >> results/results_$8_$7.ods
	grep  " " results/FME_Y1_$8_$7.dat  >> results/results_$8_$7.ods
echo RR  >> results/results_$8_$7.ods
echo Users Value  >> results/results_$8_$7.ods
	grep  " " results/RR_Y1_$8_$7.dat  >> results/results_$8_$7.ods

./Graph1.sh $7_$8 results/MT_Y1_$8_$7.dat results/FME_Y1_$8_$7.dat results/RR_Y1_$8_$7.dat $7-Fairness-Index Users Fairness Index

rm results/MT_Y1_$8_$7.dat 
rm results/FME_Y1_$8_$7.dat 
rm results/RR_Y1_$8_$7.dat 
echo  FAIRNESS $7 REPORT FINISHED!! 


