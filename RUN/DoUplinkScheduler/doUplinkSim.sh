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
# Author: Hajer BEN REKHISSA


# Uplink Scheduling

FILE="Sim"   #OUTPUT FILE NAME
NUMSIM=3  #Number of simulations
FILENAME="Multi"   # SIMULATION TYPE NAME
COUNT=1
CELS=1       # NUMBER OF CELLS
TOTALNAME=""
MINUSERS=5 # Start users
INTERVAL=5 # Interval between users
MAXUSERS=10 #max of users 

# params of LTE-SIM MULTICEL

RADIUS=1 # Radius in Km
NBUE=0 #Number of UE's
NBVOIP=0  # Number of Voip Flows
NBVIDEO=0 #Number of Video
NBBE=0 # Number of Best Effort Flows
NBCBR=1 #Number of CBR flows
#Scheduler Type PF=1, MLWDF=2 EXP= 3
FRAME_STRUCT=1  # FDD or TDD
SPEED=3 #User speed 
MAXDELAY=0.1
StopTime=10


NBUE=$MINUSERS
until [ $NBUE -gt $MAXUSERS ]; do

	# bash until loop
	#MT
	until [ $COUNT -gt $NUMSIM ]; do
       	TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_MT_"$NBUE"U"$CELS"C"".sim"
	../../LTE-Sim testUplink $RADIUS $NBUE  1 $StopTime 1 0 128 $MAXDELAY> results/$TOTALNAME
       	echo FILE $TOTALNAME CREATED!
	 let COUNT=COUNT+1
	done
	COUNT=1
	#FME
	until [ $COUNT -gt $NUMSIM ]; do
       	TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_FME_"$NBUE"U"$CELS"C"".sim"
	../../LTE-Sim testUplink $RADIUS $NBUE  2 $StopTime 0 1 128 $MAXDELAY > results/$TOTALNAME
       	echo FILE $TOTALNAME CREATED!
	 let COUNT=COUNT+1
	done
	COUNT=1
	#RR
	until [ $COUNT -gt $NUMSIM ]; do
  	      TOTALNAME=$FILE"_"$COUNT"_"$FILENAME"_RR_"$NBUE"U"$CELS"C"".sim"
	../../LTE-Sim testUplink $RADIUS $NBUE  3 $StopTime 0 1 128 $MAXDELAY > results/$TOTALNAME
   	    echo FILE $TOTALNAME CREATED!
 	let COUNT=COUNT+1
	done
	COUNT=1
let NBUE=NBUE+INTERVAL
done
echo SIMULATION FINISHED!
echo CREATING RESULTS REPORT!

# params 1 MINUSERS, 2 MAXUSERS, 3 INTERVAL, 4 FILENAME, 5 FILE, 6 NUMSIM, 7 TypeFlow, Graphic_name

# result shells

./packet_loss_ratio.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM CBR Packet-Loss-Ratio
./thoughput_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM CBR Throughput
./delay_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM CBR Delay
./spectral_efficiency_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM Spectral-Efficiency Spec-Eff
./fairnessIndex_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM  CBR Fairness-Index
./power_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM CBR power

./packet_loss_ratio.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM VIDEO Packet-Loss-Ratio
./thoughput_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM VIDEO Throughput
./delay_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM VIDEO Delay
./fairnessIndex_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM  VIDEO Fairness-Index
./power_comp.sh $MINUSERS $MAXUSERS $INTERVAL $FILENAME $FILE $NUMSIM VIDEO power

