# 4-Bit Full Adder Implementation in RTL Logic using HSPICE  

## Overview  
This repository contains the implementation of a 4-bit full adder using RTL (Register Transfer Level) logic in HSPICE. The design utilizes pulse voltage sources to simulate binary inputs and employs XOR and full adder subcircuits to compute the sum and carry outputs.  

## Table of Contents  
- [Introduction](#introduction)  
- [Code Explanation](#code-explanation)  
- [Simulation Results](#simulation-results)  


## Introduction  
A full adder is a digital circuit that computes the sum of three binary bits: two significant bits and a carry-in bit. This implementation extends the concept to a 4-bit adder, allowing for the addition of two 4-bit binary numbers along with a carry-in.  

## Code Explanation  
The HSPICE code for the 4-bit full adder is structured as follows:  

### Pulse Voltage Sources  
The code defines pulse voltage sources for the inputs of the adder:  
```plaintext  
VINA0 INA0 0 PULSE (0 5 10P 1N 1N 10N 20N)  
VINA1 INA1 0 PULSE (0 5 10P 1N 1N 20N 40N)  
VINA2 INA2 0 PULSE (0 5 10P 1N 1N 40N 80N)  
VINA3 INA3 0 PULSE (0 5 10P 1N 1N 80N 160N)  
VINB0 INB0 0 PULSE (0 5 10P 1N 1N 160N 320N)  
VINB1 INB1 0 PULSE (0 5 10P 1N 1N 320N 640N)  
VINB2 INB2 0 PULSE (0 5 10P 1N 1N 640N 1280N)  
VINB3 INB3 0 PULSE (0 5 10P 1N 1N 1280N 2560N)  
VINC INC 0 PULSE (0 5 10P 1N 1N 1500N 3000N)
```
### Logic Gates
The implementation uses XOR gates and full adder subcircuits to compute the outputs:
```plaintext
XXOR0 INB0 INC OUT_XOR0 XOR  
XXOR1 INB1 INC OUT_XOR1 XOR  
XXOR2 INB2 INC OUT_XOR2 XOR  
XXOR3 INB3 INC OUT_XOR3 XOR  
XFA0 INA0 OUT_XOR0 INC OUT_FA0_COUT S0 FA  
XFA1 INA1 OUT_XOR1 OUT_FA0_COUT OUT_FA1_COUT S1 FA  
XFA2 INA2 OUT_XOR2 OUT_FA1_COUT OUT_FA2_COUT S2 FA  
XFA3 INA3 OUT_XOR3 OUT_FA2_COUT OUT_FA3_COUT S3 FA
```
### Outputs
The outputs include the sum bits (S0, S1, S2, S3) and the carry-out bits from each full adder stage.

## Simulation Results
The simulation results can be visualized in the provided waveform image. The image illustrates the timing and behavior of the inputs and outputs during the addition process.
![FullAdderRTL](https://github.com/user-attachments/assets/85756e4d-d821-4ad4-8861-a60c6e3f230f)


