# Arty Pong Game (Vivado + VHDL)

This project implements a classic Pong (Ping-Pong) game using VHDL and Xilinx Vivado. 2 players can play.

The game is designed to run on an Arty S7-25 board and demonstrates core digital design concepts such as finite state machines, clocked logic, input handling, and hardware-based game control.

## Project Overview

This Pong game simulates two paddles and a moving ball using Arty board hardware logic.  
The system processes button inputs to control paddle movement and updates the game state synchronously with the clock.

## Features
Pong-style ball movement logic

Paddle control via hardware inputs

Collision detection (ball / paddle / walls)

Clock-driven game updates

Modular VHDL design

Pong speed control using switches

Arty pin mapping using '.xdc' constraints

## Tools Used
Language: VHDL

IDE: Xilinx Vivado

Hardware: Arty S7-25 Board

## How to Run the Project

1. Open Vivado

2. Select Open Project

3. Choose 'proj1_razaa.xpr'

4. Make sure the correct Arty board/part is selected

5. Run:
-  Synthesis
-  Implementation
-  Generate Bitstream

7. Program the Arty board

8. Use the assigned buttons to control the paddles


## Controls

Buttons used to control a player. press to 'hit' pong

Ball movement is automatic

Reset logic returns the game to its initial state

Switch used to change pong speed
