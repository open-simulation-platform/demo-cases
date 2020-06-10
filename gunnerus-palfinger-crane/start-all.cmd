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
for /f "tokens=2" %%i in ('tasklist ^| find "cse-server-go"') do ( taskkill /F /PID %%i )
echo.

echo Starting FMU proxies
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9090 fmus\PMAzimuth.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9091 fmus\PMAzimuth.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9092"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9093 fmus\TunnelThruster.fmu"
start cmd /C ""%JAVA_HOME%"\bin\java -jar "%cosimDemoAppPath%"\fmu-proxy.jar -thrift/tcp 9094 fmus\VesselFmu.fmu"

echo Starting cse-server-go
start cmd /C ""%cosimDemoAppPath%"\cosim-demo-app.exe 1>debug.txt 2>&1 | type debug.txt"
timeout 2 > nul
start http://localhost:8000