psfile=iran_zagros.ps
projection=-JM17
region='-R42/66/22/42'
faults=/home/user/Downloads/iran
LARG_grd=iran.GRD
main_grd=Iran_500m.grd
gradient_grd=ombre.grd

####################### topo ####################################
psbasemap   $region $projection  --FONT_ANNOT_PRIMARY=8P    --MAP_FRAME_WIDTH=0.030i -Ba1f1/a1f0.5WSne  -K -P > $psfile
grd2cpt $LARG_grd  $region -L0/4000 -S-1500/3000/900	-Cgray	-Z	> colors.cpt
grdgradient $LARG_grd -A40	-Gombre.grd	-Nt1
grdimage  $projection	 $region  $LARG_grd	-Ccolors.cpt	-Iombre.grd	-O -K -P	>>	$psfile
gmt pscoast -V  $region -O $projection -K  -S50/209/255   -C50/209/255 -P  -Na/2p,black  -W1  -Di >>  $psfile
################## faults ##################################### 
gmt psxy "reversel.txt"    $projection -W0.8p,red  -K -O  -P -Rd42/66/22/42 >> $psfile
gmt psxy "thrustr.txt"     $projection  -W1p,#800000 -K -O -P -Rd42/66/22/42 >> $psfile
gmt psxy "thrustleft.txt"  $projection -W1p,#800000 -K -O -P -Rd42/66/22/42 >> $psfile
gmt psxy "normal.txt"       $projection -Wthin,red,- -K -O -P -Rd42/66/22/42  >> $psfile
gmt psxy "ssttrr.txt" $projection -W1p,red -K -O -P -Rd42/66/22/42  >> $psfile
gmt psxy "strike-slipl.txt" $projection  -W1p,red -K -O -P -Rd42/66/22/42  >> $psfile

############## stations location whit name ####################################
echo 51.81 26.42  Persian Gulf | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile
echo 59.30 24.95  Oman Sea | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile
echo 51.5 38.6  Caspian Sea | gmt pstext -R -J -O -K -F+f10p,Helvetica-Bold,black  >> $psfile
echo 45.7 27.5  Saudi Arabia | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile  
echo 44.9 31.9  Iraq | gmt pstext -R -J -O -K -F+f11p,Helvetica-Bold,black  >> $psfile   
echo 43.00 39.18 TURKEY  | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile
echo 63.5 32.00  AFGHANISTAN  | gmt pstext -R -J -O -K -F+f10p,Helvetica-Bold,black  >> $psfile 
echo 64.60 27.3   PAKISTAN | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile
echo 44.48 40.35   ARMENIA | gmt pstext -R -J -O -K -F+f6p,Helvetica-Bold,black  >> $psfile  
echo 59.60 39.50   Turkmenistan  | gmt pstext -R -J -O -K -F+f11p,Helvetica-Bold,black  >> $psfile
echo 47.90 40.60   Azerbaijan  | gmt pstext -R -J -O -K -F+f9p,Helvetica-Bold,black  >> $psfile

############## station location with triangle or circle #####################################
awk '{ print $1-.2,$2-.3,'18','0','5','1'}' stations_new.txt>stations_new_temp.txt
gmt psxy  stations_new_temp.txt $projection $region  -St0.24 -W0.2/0/0/0  -G0/104/16  -O -K -N >> $psfile

############## legend STATIONS ############################## 
gmt pslegend $region $projection -O -K -DjBL+w4.5c+o0.3c -F+p0.5p+gdarkgray+s --FONT=8<<EOF>>$psfile
H 10p Helvetica-Bold Legend
S 0.2c - 0.55c - 1p,#800000 0.75 Thrust Fault
S 0.2c - 0.55c - 1p,red,- 0.75 Normal Fualt
S 0.2c - 0.55c - 1p,red 0.75 Strike-slip Fault 
S 0.3c t 0.24 green - 0.75 Broadband Stations
S 0.2c - 0.55c - 1p,black 0.75 Political Border
S 0.2c - 0.55c - 1p,white 0.75 Seismogenic zone Border

EOF
ps2pdf $psfile
