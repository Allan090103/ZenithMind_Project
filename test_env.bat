@echo off
echo Testing Java... > java.log
java -version >> java.log 2>&1
echo Done Java. >> java.log

echo Testing Maven... > mvn.log
call mvn -v >> mvn.log 2>&1
echo Done Maven. >> mvn.log

echo Testing Port 3307... > port.log
netstat -an | findstr 3307 >> port.log 2>&1
echo Done Port. >> port.log
