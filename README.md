# Active Cell Balancing

This project focuses on designing an active cell balancing circuit for a 3s1p battery pack using a bidirectional flyback converter and a two-switch bidirectional flyback converter. The design allows for efficient energy transfer between cells, improving the overall performance and lifespan of the battery pack.

## Overview

The circuit is designed to use an additional cell for balancing purposes, transferring energy from individual cells to a common cell using flyback converters. The two-switch bidirectional flyback converter facilitates common cell-to-pack balancing. The controllers are designed to operate the converters in current control mode, allowing precise control over the input currents of the converters.

The effectiveness of the design was validated by charging the battery pack with a 2.5A current source and operating the converters under different current references.

## Specifications

- **Nominal Voltage of Each Cell:** 3.7V
- **Charging Current:** 2.5A
- **Switching Frequency:** 200kHz
- **Battery Pack Type:** 3s1p

## Features

- **Bidirectional Flyback Converter:** Allows efficient cell-to-common cell energy transfer.
- **Two-Switch Bidirectional Flyback Converter:** Enables common cell-to-pack balancing.
- **Current Control Mode:** Ensures precise regulation of converter input currents.

## Usage
- Run the MATLAB script to generate the parameters for running the simulation.
- The **FinalCircuit** Simulink Model file is the final design.
- Please refer to the Project Report for details on modelling of converters, design of controllers and simulation results.
