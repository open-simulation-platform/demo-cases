
# README

1. Update `JAVA_HOME` and `cosimDemoAppPath` in `start-all.cmd` to point to your java installation and cosim demo app. 
2. Update the initial value of variable `vesselZipFile` to point to to `ShipModel.zip` in the `fmus/resources` folder. The path must be absolute.
3. Run __run-windows.cmd__. This will start the demo-application server.
4. Pass the folder containing this file to the demo-application.

**Table 1:** *FMUs*

 |Model| FMU| Description |
 | --- | --- | ---| 
 | Hull | VesselFmu |6DOF hull model including the environment model |
 | Main Thruster| PMAzimuth | Two Azimuth thrusters as the main propulsion|
 | Thruster Drive| ThrusterDrive | Thruster drive calculates the rmp of the thruster given the desired thrust command (propulsion force) [1] |
 | Power Plant| PowerPlant | Provides power to the thruster drive [2]|
 | Waypoint Provider| WaypointProvider2DOF | Reference position of the ship  |
 | Trajectory controller | TrajectoryController.fmu | Calculates the propulsion force and and azimuth angle(s) based on the waypoints | 
 
## Requirements

* 64-bit Windows
* A 64-bit JDK ( >= JDK 8) is required in order to run some of the FMUs.
There might be issues with JDK 12. JDK 8 is known to work.

### References and Footnotes
[1] S. Skjong, M. Rindarøy, L. T. Kyllingstad, V. Æsøy, and E. Pedersen, “Virtual prototyping of maritime systems and operations: applications of distributed co-simulations,” J. Mar. Sci. Technol., pp. 1–19, 2017.  
[2] S. Skjong and E. Pedersen, “A real-time simulator framework for marine power plants with weak power grids,” Mechatronics, vol. 47, pp. 24–36, Nov. 2017.  

