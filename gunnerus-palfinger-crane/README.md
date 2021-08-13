
# README

1. Update `JAVA_HOME` and `cosimDemoAppPath` in `start-all.cmd` to point to your java installation and cosim demo app.
   Example: set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_221, set cosimDemoAppPath=C:...\cosim-demo-app-v0.7.0-windows\bin
2. In `config\OSPSystemStructure.xml` update the value of variable `vesselZipFile` to point to `ShipModel.zip` in the `fmus/resources` folder. The path must be absolute.
3. Run __start-all.cmd__. This will start the demo-application server.
   Note: In the first time you will be asked to provide a license file. Use the file ShipX.lic that is located in the root folder for this case.
4. Under simulation setup, pass the folder containing the OSPSystemStructure file to the demo-application.

## Requirements

* 64-bit Windows
* A 64-bit JDK ( >= JDK 8) is required in order to run some of the FMUs.
There might be issues with JDK 12. JDK 8 is known to work.
