** --------------------------------------** 
.include model.sp

VDD VDD 0 1.1
.GLOBAL VDD
  
.DC VINA 0 1.1 0.01
.TRAN 10p 75n



****************************************** Main *************************************
VINA INA 0 0 PULSE(0 1.1 5p 0.001n 0.001n 10n 40n)
*VINB INB 0 0 PULSE(0 1.1 5p 0.001n 0.001n 20n 40n)
*VINC INC 0 0 PULSE(0 1.1 5p 0.001n 0.001n 40n 80n)


XNOT INA OUT NOT
XNOT1 OUT OUT1 NOT
XNOT2 OUT OUT2 NOT
XNOT3 OUT OUT3 NOT

cload OUT 0 1f

* Measure static power dissipation(average)
.measure tran ivdd avg i(VDD) FROM 10p TO 25p
.measure avgpwrS PARAM='-ivdd*1.1'

* Measure Total power dissipation(average)
.MEASURE TRAN avgpwrT avg POWER FROM 10p TO 25p



.PRINT TRAN V(INA) V(INB) V(OUT_NAND)
***********************************************Main******************************

**-------------------NOT
.SUBCKT NOT ina out
Mn1 VDD VDD OUT 0 nmos L=32n W=1.0u
Mn2 OUT INA 0 0 nmos L=32n W=1.0u
.ENDS NOT
**-------------------------Not2-paSTRANS-----------
.SUBCKT NOTB in out
Mp1 OUT IN 0 VDD pmos L=32n W=2.0u
Mn1 OUT IN VDD 0 nmos L=32n W=1.0u
.ENDS BOTB
**--------------------NAND------------
.SUBCKT NAND A B OUT
Mp1 OUT A VDD VDD pmos L=32n W=2.0u
Mp2 OUT B VDD VDD pmos L=32n W=2.0u

Mn1 OUT A SMN1 0 nmos L=32n W=2.0u
Mn2 SMN1 B 0 0 nmos L=32n W=2.0u
.ENDS NAND
*----------------nOR----------------------------
.SUBCKT NOR A B OUT
Mp1 OUT B SMP1 VDD pmos L=32n W=4.0u
Mp2 SMP1 A VDD VDD pmos L=32n W=4.0u

Mn1 OUT A 0 0 nmos L=32n W=1.0u
Mn2 OUT B 0 0 nmos L=32n W=1.0u
.ENDS NOR
*------------------------------------Nor-PASTRANS-----------
.SUBCKT NOR3 A B E OUT
Mp1 OUT B SMP1 VDD pmos L=32n W=4.0u
Mp2 SMP1 A dis1 VDD pmos L=32n W=4.0u

XNOT E out_not INV


MpE1 VDD out_not dis1 VDD pmos L=32n W=4.0u


Mn1 OUT A ghat2 0 nmos L=32n W=1.0u
Mn2 OUT B ghat2 0 nmos L=32n W=1.0u


MnE2 ghat2 E 0 0 nmos L=32n W=1.0u
.ENDS NOR3
*--------------------OR-----------------------
.SUBCKT OR A B OUT
XNOR A B OUT_NOR NOR
XNOT OUT_NOR OUT INV
.ENDS OR

*---------------------------------------
*------------XOR---------------------------
.SUBCKT XOR_NEW INA INB OUT
Mp1 OUT1 INA VDD VDD pmos L=32n W=2.0u
Mn2 OUT1 INA 0 0 nmos L=32n W=1.0u
Mp3 OUT2 INB OUT1 VDD pmos L=32n W=2.0u

Mn4 INA INB OUT2 0 nmos L=32n W=1.0u
Mp5 OUT OUT2 VDD VDD pmos L=32n W=2.0u
Mn6 OUT OUT2 0 0 nmos L=32n W=1.0u
.ENDS XOR_NEW
*---------------------------------------
*--------Full Adder Cmos-------------------------------
.SUBCKT FA INA INB INC CARRY SUM
Mp1 OUT0 INA VDD VDD pmos L=32n W=2.0u
Mp2 OUT0 INB VDD VDD pmos L=32n W=2.0u
Mp3 OUT2 INC OUT0 VDD pmos L=32n W=2.0u

Mp4 DMp4 INA VDD VDD pmos L=32n W=2.0u
Mp5 OUT2 INB DMp4 VDD pmos L=32n W=2.0u

Mp7 OUT3 INA VDD VDD pmos L=32n W=2.0u
Mp8 OUT3 INB VDD VDD pmos L=32n W=2.0u
Mp9 OUT3 INC VDD VDD pmos L=32n W=2.0u

Mp11 DMp11 INA VDD VDD pmos L=32n W=2.0u
Mp12 DMp12 INB DMp11 VDD pmos L=32n W=2.0u
Mp13 OUT4 INC DMp12 VDD pmos L=32n W=2.0u



Mp10 OUT4 OUT2 OUT3 VDD pmos L=32n W=2.0u
Mn7 OUT4 OUT2 SMn7 0 nmos L=32n W=1.0u



Mp14 SUM OUT4 VDD VDD pmos L=32n W=2.0u
Mn8 SUM OUT4 0 0 nmos L=32n W=1.0u

Mp6 CARRY OUT2 VDD VDD pmos L=32n W=2.0u
Mn6 CARRY OUT2 0 0 nmos L=32n W=1.0u



Mn1 OUT2 INA SMn1 0 nmos L=32n W=1.0u
Mn2 SMn1 INB 0 0 nmos L=32n W=1.0u

Mn3 OUT2 INC SMn3 0 nmos L=32n W=1.0u
Mn4 SMn3 INA 0 0 nmos L=32n W=1.0u
Mn5 SMn3 INB 0 0 nmos L=32n W=1.0u

Mn9 SMn7 INA 0 0 nmos L=32n W=1.0u
Mn10 SMn7 INB 0 0 nmos L=32n W=1.0u
Mn11 SMn7 INC 0 0 nmos L=32n W=1.0u

Mn12 OUT4 INA DMn12 0 nmos L=32n W=1.0u
Mn13 DMn12 INB DMn13 0 nmos L=32n W=1.0u
Mn14 DMn13 INC 0 0 nmos L=32n W=1.0u


.ENDS FA



.END 
 
