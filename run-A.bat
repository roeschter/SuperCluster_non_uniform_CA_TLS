
set SERVER=D:\synadia\software\nats-server\nats-server.exe

rem %SERVER% -c nats_A1.config
start "" /min %SERVER% -c nats_A1.config
start "" /min %SERVER% -c nats_A2.config

pause

taskkill /IM nats-server.exe /F
