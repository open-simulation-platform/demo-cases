
# README

1. Update `JAVA_HOME` and `cosimDemoAppPath` in `start-all.cmd` to point to your java installation and cosim demo app. 
2. Update the initial value of variable `vesselZipFile` to point to to `ShipModel.zip` in the `fmus/resources` folder. The path must be absolute.
3. Run __run-windows.cmd__. This will start the demo-application server.
4. Pass the folder containing this file to the demo-application.

## Requirements

* 64-bit Windows
* A 64-bit JDK ( >= JDK 8) is required in order to run some of the FMUs.
There might be issues with JDK 12. JDK 8 is known to work.
