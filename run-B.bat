
set SERVER=D:\synadia\software\nats-server\nats-server.exe

start "" /min %SERVER% -c nats_B1.config
start "" /min %SERVER% -c nats_B2.config

pause

taskkill /IM nats-server.exe /F
