@echo off

set JAVA_HOME=
set cosimDemoAppPath=

echo Setting JAVA_HOME to %JAVA_HOME%. 
echo Please alter in script as needed.
echo.
java -version
echo.

echo terminating running fmu-proxies
for /f "tokens=1" %%i in ('jps -m ^| find "fmu-proxy"') do ( taskkill /F /PID %%i )
echo.
echo terminating running cse-server-go
for /f "tokens=2" %%i in ('tasklist ^| find "cosim-demo-app"') do ( taskkill /F /PID %%i )
echo.

echo Starting FMU proxies

start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9090 ./fmus/VesselFmu.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9091 ./fmus/PMAzimuth.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9092 ./fmus/PMAzimuth.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9093"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9094"

echo Starting cosim-demo-app
start cmd /k ""%cosimDemoAppPath%"\cosim-demo-app.exe"
timeout 2 > nul
start http://localhost:8000

