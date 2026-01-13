@echo off
echo Starting server... > server_output.txt
call mvn spring-boot:run >> server_output.txt 2>&1
echo Done. >> server_output.txt
