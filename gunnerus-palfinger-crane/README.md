
# README

1. Several of the FMUs in this configuration requires the environment valiable `JAVA_HOME` to be set your JDK.
   Example: `set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_221`
2. In `config\OSPSystemStructure.xml` update the value of variable `vesselZipFile` to point to `ShipModel.zip` in the `fmus/resources` folder. The path must be absolute.
3. The first time you load this configuration, you will be asked to provide a license file. Use the file ShipX.lic that is located in the folder demo-cases\gunnerus-waypoint-following

## Requirements

* 64-bit Windows
* A 64-bit JDK ( >= JDK 8) is required in order to run some of the FMUs.
There might be issues with JDK 12. JDK 8 is known to work.
