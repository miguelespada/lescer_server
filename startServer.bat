@echo off
cd C:/Users/oculus/Desktop/lescer_server/tmp/pids
del server.pid
cd C:/Users/oculus/Desktop/lescer_server/
rails s
exit