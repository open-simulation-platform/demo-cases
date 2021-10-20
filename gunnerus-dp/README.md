# Gunnerus-DP

The purpose of this demo case is to demonstrate separation of control systems and simulators in `libcosim` and the use of network FMUs.

This toplogy is common when performing hardware-in-the-loop (HIL) simulations. In a HIL setup, the control system is deployed on production hardware and hooked up to an external simulator. The external simulator can be deployed to whatever hardware is available as long as it enables an interface compatible with the control system. The same toplogy can also be seen when running software-in-the-loop (SIL) simulations. SIL is typically used to test and verify system functionality and it is not a requirement that the control system is deployed to production hardware.

This demo case demonstrates that doing simulations with this kind of topology is feasible using `libcosim` and the OSP configuration format. The case simulates a DP controlled vessel performing a box maneuver while exposed to external forces. NTNU's research vessel, Gunnerus has been used as reference for both the vessel and control plant.

## Documentation

A more thorough documentation and description of this demo case can be found [here](https://open-simulation-platform.github.io/cosim-demo-app/Gunnerus-DP) 

## Source Code
The source code for the network FMU used in this use can be found [here](https://github.com/open-simulation-platform/fmi-udp-adapter)
